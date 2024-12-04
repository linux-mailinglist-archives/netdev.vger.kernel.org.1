Return-Path: <netdev+bounces-148948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0D9E3955
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455C228237A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B41B3952;
	Wed,  4 Dec 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="DZd7wSIk"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1A1B3950;
	Wed,  4 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313394; cv=none; b=o8AdxHppkYFgPqBocgMJb57f6ny52lAqGJ6kLVWNuaXNSovcuMFiaiJVWwMqQbn1Fpw5TDKBjeZI8Q0oatoXeUNbbtVhVWlPjPMVYAGrH8T3h4vgBA2t47rhPD41LR+l3uOeQ6lC4SBNZ6zuiwfo4utlGGM4C3P1XPCHWT+cmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313394; c=relaxed/simple;
	bh=gfrZtkK4A+DOGZgYgjVo7j3CV+EEQ4cZ7jeW9wIdt5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKWrHOzGdkt15T2MxVRpe68s5sPbDxzIzawMa5T1Yxg2kELGjFnnE0EhA8KC77aMiChJgUfjdTCQRSWcRIZ027o+g+K91OOlzoZDWzTXBByhPzYK2yKvNOsum819gZc3iXMOhdVZD70QXN8ROmpYKeWw/bUglTnImnYHwO/E2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=DZd7wSIk; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Y3G3B0qktzPk68;
	Wed,  4 Dec 2024 12:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1733312838; bh=gfrZtkK4A+DOGZgYgjVo7j3CV+EEQ4cZ7jeW9wIdt5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From:To:CC:
	 Subject;
	b=DZd7wSIkv3/2Bo17KZyUK+M4I12AusFLMbl7/xkJGRxWEaQiOZSMLxZsSq97WfoIe
	 xCtO+mNR1btfdG0KMG7ZRmCKkqizO0LmQQVVjKyOhmVvQOC2MTQ+DJEjBgDGerCxBH
	 WSG5ItX77bL4K0alAUoE3mRAw9zgZ8MppkthHJXt+ZnE141KxJejQpHtuYBkUJSXe4
	 GBpmsAaPOX2vrtIpCo7BrHmasRwlLxcpmw5Fd8sob9j6YxPdVi8wrhUtgUOh8ldJIJ
	 +Ntw7gLEmCOD15F5k0CWCA7AmBV2OjYXAZBOTk1aev7Hall1AE4Y160UydnmJAw87o
	 ENwrdWn1nEgCQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.37.42
Received: from [131.188.37.42] (faui7y.informatik.uni-erlangen.de [131.188.37.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/suPM4bff5/GBbiflfuJQPB+JDQHv2SKk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Y3G374hqTzPkl7;
	Wed,  4 Dec 2024 12:47:15 +0100 (CET)
Message-ID: <ce09216d-ccb2-4cf3-8c68-4de468411db5@fau.de>
Date: Wed, 4 Dec 2024 12:47:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: netem: account for backlog updates from child
 qdisc
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241125231825.2586179-1-martin.ottens@fau.de>
 <20241202191312.3d3c8097@kernel.org>
Content-Language: en-US, de-DE
From: Martin Ottens <martin.ottens@fau.de>
In-Reply-To: <20241202191312.3d3c8097@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03.12.24 04:13, Jakub Kicinski wrote:
> I don't understand why we need to perform packet accounting=20
> in a separate new member (t_len). You seem to fix qlen accounting,
> anyway, and I think sch->limit should apply to the qdisc and all
> its children. Not just qdisc directly (since most classful qdiscs
> don't hold packets).

Netem is a classful qdisc but different from others because it holds=20
packets in its internal tfifo and optional additionally in a child=20
qdisc. However, sch->limit currently only considers the packets in=20
the tfifo and not the packets hold by a child, but child qdiscs=20
expect this value to refer to the number of packets that are in=20
netem and all its children together. If the children change this=20
value (using 'qdisc_tree_reduce_backlog'), then the number of=20
packets in the tfifo no longer matches sch->limit.
By adding t_len, the number of packets in the tfifo will be tracked=20
independently from sch->limit therefore sch->limit can be changes=20
by children without unwanted behavior. t_len is required, because=20
currently the limit option of netem refers to the maximum number=20
of packets in the tfifo - therefore the behavior of netem is not
changed by this patch.

> I'm not a qdisc expert, so if you feel confident about this code you
> need to explain the thinking in the commit message..

With the patch I try to fix the error without changing the behavior=20
of netem (e.g., change the meaning of the limit option to apply to=20
the tfifo length and the packets in the child qdisc). Maybe there=20
are even better approaches - I am happy about any feedback. I will=20
revise the explanation in the patch to make this clearer and=20
resubmit it.

