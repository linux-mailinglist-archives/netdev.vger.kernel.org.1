Return-Path: <netdev+bounces-175685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC3A671FE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7281219A3CC2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D851E20A5E0;
	Tue, 18 Mar 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Z6fYqpJ6"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7A209677
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295588; cv=none; b=G5jbji+FBJDpjvRu3EilBsXVXLy0LW8Xi7Crc4SWmDJXyq7gZeKc//4xwZYh5tYq7X+b/u5QILvryQc+qeM4IRhOZS/zH/YAbnEe412mNaHQIn6p6uF866qke+4/UFbpBKFK4tb3tXz+PZEe9rccOET8h9JF//rWRAX//BUCRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295588; c=relaxed/simple;
	bh=eZnMStUD78QbeuU+LCEoJ7naNiq0Q+kzNYsGMczVxQw=;
	h=Cc:Subject:Mime-Version:References:Content-Type:In-Reply-To:To:
	 From:Date:Message-Id; b=k9xgc2ufAtQhnAD5HEwJIEnmjX6vP2NaDuv+MDMtbAIzR8xEDIA0k9HakZP6WIxWqv7RccCXZvm/qeJMiV3fPRNEREgW9uT6gX9FokhvDc85dmSvy0G9Jv13vSY3bIY1BOZOzHZ5YlcdxywexXQfhceAGoOlJ7o55cdpw5rTeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Z6fYqpJ6; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742295576; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sDuS+S3s6CZeqCEM3uyW5ymzfn8kVrt3DL9X9xoc8p4=;
 b=Z6fYqpJ6ZSBUOK6w5UhAKIZnvlMtvgiHQv1fBuoXtqBYH1+JgQWTTfrSdolI80ztP0jEZQ
 pUQbeeJmOu/G+wXTBrEqtWgmRJ5/oSd9BvoCOC8MSvJ3Q9Em4B1J2ReP+TjafjWJ3SAeJW
 p23KgHwJG/claho6UKGW/x9A7PJdCUFUFGlwE6Ull8ue1cVdjHpyUkvBFiWSIiJPlL1C9Q
 Fp1MVfd6fxXB2JMv7quOETJbW5deeI00evYs2FTTDOe4P4LwkQHL6n7TmXu/vvprl1vkBg
 yzJZTRGaUL/0+ZvfVCk3ndr2DQFHmcKpXUknTHwHz0XMqySLwMvuQNqiyC35Ng==
Cc: "Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>, 
	<leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100827.555320-3-tianx@yunsilicon.com> <20250310063429.GF4159220@kernel.org> <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com> <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com> <CAMuHMdXxkvE=o7VOpPqSo3dkd6=YP8iWJ5V_=S=uAyrCBygEjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+267d95217+1112b6+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <CAMuHMdXxkvE=o7VOpPqSo3dkd6=YP8iWJ5V_=S=uAyrCBygEjQ@mail.gmail.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Tue, 18 Mar 2025 18:59:32 +0800
Message-Id: <ca224adb-9604-4e96-b34e-79620ab7ae54@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 18:59:34 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>

On 2025/3/18 18:29, Geert Uytterhoeven wrote:
> On Tue, 18 Mar 2025 at 11:06, Xin Tian <tianx@yunsilicon.com> wrote:
>> On 2025/3/12 17:17, Xin Tian wrote:
>>> On 2025/3/10 14:34, Simon Horman wrote:
>>>> On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
>>>>> The command queue is a hardware channel for sending
>>>>> commands between the driver and the firmware.
>>>>> xsc_cmd.h defines the command protocol structures.
>>>>> The logic for command allocation, sending,
>>>>> completion handling, and error handling is implemented
>>>>> in cmdq.c.
>>>>>
>>>>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>>>>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>>>>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>>>>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>>>>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>>>> Hi Xin,
>>>>
>>>> Some minor feedback from my side.
>>>>
>>>> ...
>>>>
>>>>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers=
/net/ethernet/yunsilicon/xsc/pci/cmdq.c
>>>> ...
>>>>
>>>>> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, i=
nt size)
>>>>> +{
>>>>> +   struct xsc_cmd_prot_block *block;
>>>>> +   struct xsc_cmd_mailbox *next;
>>>>> +   int copy;
>>>>> +
>>>>> +   if (!to || !from)
>>>>> +           return -ENOMEM;
>>>>> +
>>>>> +   copy =3D min_t(int, size, sizeof(to->first.data));
>>>> nit: I expect that using min() is sufficient here...
>>> Ack
>> min(size, sizeof(to->first.data)) will lead to a compile warning.
>> size is int and sizeof(to->first.data) is size_t.
>> So I kept this in v9
> Sizes should be unsigned, perhaps even size_t (depending on the
> expected maximum size).
> What if someone passes a negative number? Then copy will be negative
> too.  When calling memcpy(), it will be promoted to a very large
> unsigned number, ... boom!
>
> Gr{oetje,eeting}s,
>
>                          Geert
You're right; I think I still have some sizes that need to be modified.=20
Thanks for the reminder!=F0=9F=99=82
>

