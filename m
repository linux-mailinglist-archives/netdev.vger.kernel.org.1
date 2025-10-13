Return-Path: <netdev+bounces-228708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26941BD2CF5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E8D4F1213
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0FF2609D9;
	Mon, 13 Oct 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="B82ARk1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF534BA2D
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355658; cv=none; b=SQFGJ4mDvcdOLcHNeNAHWtU66O6jFelzoY5CmLOp/te+ZRPxQXjY4wfNYGjwkBfV3dF4sXrX1I0NJ6HSI1NGz9TPAOGWmDlvuTsMMTu76+6/VTSni3p1ITdRKPHIt+soqtF8U84pHTjJk+CIxuhkjDnmevDS25vpWIse2UY7zFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355658; c=relaxed/simple;
	bh=uk4LKFdpJMLTA/xiRvdkdBXYjWK9L0XEP4+c/M0T/fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/ub0yuVI9xhTzZTB9o96CkPL636h9od5IRXM/Dk33+cu0Ebh3KyNnAilzMZjCPaFoHzsJHWtx3sEpMRsHNkVhRsMttITPNZMwybCgGQT09H6+qky6asnMVOesv/UQrBatAnF5O4axgSvvCZEUjVkBY5jw/e/n/4QKxVBoAhCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=B82ARk1c; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1760355108; bh=uk4LKFdpJMLTA/xiRvdkdBXYjWK9L0XEP4+c/M0T/fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B82ARk1c4axhPbU2bRBFeaEr9DHHTMrHNed3QO6WxnZcMtnDSow14VWSWARUAxMwl
	 hGm7Cr3Zr2aGcKsfqQBYLJ/MqviNKLLPWEgBB3DDhiC1yr2gsuGknSJWihI8vDMuwx
	 GdBrUeNYTtcSyOkTb8YOo9Iur4/RiOCad14Ktz4UL9SLwkF3YQp3VTpsdAhvPQJU4N
	 Z7MbHJ0TwXxegEbvckhlKVYQSgXUu8EsVtKl3h8XfqDgQx/WjmPgmAEVEL5HU6Wom5
	 xDtus4FcZGJKnuqp8rmppxry88h/jf00/9vQzVLJatX3FICPzxelgKNw9wQopyVZb2
	 YUF5wfDaBLIRg==
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] Multi-queue aware sch_cake
In-Reply-To: <CAM0EoMnkOoA1x0o4VQ35kS-Sa69QSCRwmQBtVx5hEF9qo6rv4A@mail.gmail.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
 <CAM0EoMnkOoA1x0o4VQ35kS-Sa69QSCRwmQBtVx5hEF9qo6rv4A@mail.gmail.com>
Date: Mon, 13 Oct 2025 13:31:48 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v7kj597f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Wed, Sep 24, 2025 at 8:16=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> This series adds a multi-queue aware variant of the sch_cake scheduler,
>> called 'cake_mq'. Using this makes it possible to scale the rate shaper
>> of sch_cake across multiple CPUs, while still enforcing a single global
>> rate on the interface.
>>
>> The approach taken in this patch series is to implement a separate qdisc
>> called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
>> in a couple of aspects:
>>
>> - It will always install a cake instance on each hardware queue (instead
>>   of using the default qdisc for each queue like 'mq' does).
>>
>> - The cake instances on the queues will share their configuration, which
>>   can only be modified through the parent cake_mq instance.
>>
>> Doing things this way does incur a bit of code duplication (reusing the
>> 'mq' qdisc code), but it simplifies user configuration by centralising
>> all configuration through the cake_mq qdisc (which also serves as an
>> obvious way of opting into the multi-queue aware behaviour).
>>
>> The cake_mq qdisc takes all the same configuration parameters as the
>> cake qdisc, plus on additional parameter to control the sync time
>> between the individual cake instances.
>>
>> We are posting this series to solicit feedback on the API, as well as
>> wider testing of the multi-core shaper.
>>
>> An earlier version of this work was presented at this year's Netdevconf:
>> https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate=
-limiting-across-cpu-cores.html
>>
>> The patch series is structured as follows:
>>
>> - Patch 1 factors out the sch_cake configuration variables into a
>>   separate struct that can be shared between instances.
>>
>> - Patch 2 adds the basic cake_mq qdisc, based on the mq code
>>
>> - Patch 3 adds configuration sharing across the cake instances installed
>>   under cake_mq
>>
>> - Patch 4 adds the shared shaper state that enables the multi-core rate
>>   shaping
>>
>> A patch to iproute2 to make it aware of the cake_mq qdisc is included as
>> a separate patch as part of this series.
>>
>
> For this version of the patchset
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks!

> Q: Does Eric's riddance of busylock help?

Good question! Probably not for cake_mq usage itself, but maybe it'll
change the baseline? We'll test this before sending a non-RFC :)

-Toke

