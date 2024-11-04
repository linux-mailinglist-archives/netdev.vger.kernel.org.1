Return-Path: <netdev+bounces-141718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637459BC19A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5571F22C5D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B021AF0AD;
	Mon,  4 Nov 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="CBEO/hLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqJIq84K"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E8139CFF;
	Mon,  4 Nov 2024 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764011; cv=none; b=Q4B1yZQpVrPYrXH573atR9Qqhj7aEOGPDf7KYy4iRmNtUS+feerQq2ZWncFPOnC4ve7Jbrn6zT62BYMNpevKfGreI3egtJXMLi8Isz1hI0KENWOtHKKI9HJK0QduBd283ZOAXkUqgMV65ci6urNGiKm+vjrhP8iNCYrZJAFVUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764011; c=relaxed/simple;
	bh=gJrNY5jmVFl56ZQcQ51n0qJ4WLCy2y3He/ahNcZQiGc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q1jFkYXDq6c9vsccHaZuzQXOdx6VLA7vz2gwxzFIKvMehqDh9QBolzE1YfbLfn8J3egDxWUhO9CKgDUViQbP3WqE5HBuIWuWoMlyz6B8ULgkD2O0ZwY8hxpc+gtRQY8hxZIqclY5adIWP15tmQWBgPJXa/sH5LWUuvpAvp+v3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=CBEO/hLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqJIq84K; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8846B1140215;
	Mon,  4 Nov 2024 18:46:47 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Mon, 04 Nov 2024 18:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730764007;
	 x=1730850407; bh=EpB0U19Yt4xOY61USjZlduj31mhpmzMHLvFX+vYCq/k=; b=
	CBEO/hLJh5o9m5fPFcbGpr0z1cDnIUNQpcv+Dwlw5aWgnwSJXUn1SdmIHovJWE5O
	toBOFmd2aKh40cj46lf4mL0/4ye95xih701tHBXRncScKyHm42HPy//a/sPihzyR
	kFTvHn05HJs4gbMcM5e7maHMjb5DjYKY7j4OAvwaN6Xv/AILiCgyhlu58FKYCEEx
	icebnB0Tx17OXkskuI4sizixSNFqI2xSYpjVtfTLr/lwfgXtfKPLcs9PhKzXw4Os
	ZK4CbAs6/qB+lyPTXna6Vmb921NHJXgkPnuX7/LpYKN/+kU5Qxv8piUfd/GmWw7y
	wwYh91OkrFJKMmL/V28aZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730764007; x=
	1730850407; bh=EpB0U19Yt4xOY61USjZlduj31mhpmzMHLvFX+vYCq/k=; b=f
	qJIq84KRRdil9COQfaAhocKF4V27i68zgfqQOxs9nKJ+dQEG5rUhCUoNiQivH7tm
	FzURArQOb33SWhdOEs/qlZ8QkcljDId84vKR/tUvBAlqZlOEunmmguoqv7vZzl/u
	7j0A4CdvgOb+LrtSB+HcRVR7QJb+0r9nXXHjYsELFGIRFk+sdTDcODg2OJcO0s84
	01nksDR85iTEwbCwzD/4JkTiGiirD6oVABK+fShf4n9cyesY+hdKwRMf3KBbS+Oz
	JnWxsR9mmzqLc5azAKoCkfbV6kKgFOlR2l+KBHy1B4KZrdnuA3tVsAJ/HRc4lmk8
	iGGijB/NhO8YsqSdMASvA==
X-ME-Sender: <xms:5lwpZzlCj4PrIOD_k7DHmsjvxYZD0RjC5Jks4TEXdyKWwYAyhmj7bA>
    <xme:5lwpZ22EAHyHZPZvzeWlANv3dBsG4JpWRfT8BMzNmCop-_42ztFBWpefuRxXtHIJg
    ISruPIWxcBgH_uEsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedufefh
    ffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvg
    ifrdhgohhsphhouggrrhgvkhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepmhhi
    tghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehprghvrg
    hnrdgthhgvsggsihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepvhhikhgrshdr
    ghhuphhtrgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:5lwpZ5qoDtUDKCvjuYCQH6Wk_3lUod4YFSah10s1V3P8JhQ_RpDmfA>
    <xmx:5lwpZ7mRkyG8CMq9GRpRTvXQbunfiiK2pdVJ2v1jzJ2OJXAY5fn4lA>
    <xmx:5lwpZx0GkeG7MSwda5f5akhxwc8B_0C-LsK19dT3FXQ8_6orjiUD4A>
    <xmx:5lwpZ6tE4J_PcjetBGP9E3_PLc92pYY2ARF3mh5i3IOWWg26Cr1jkA>
    <xmx:51wpZ_MvnYQ_tkpDdVm1SPcvbpqL7R9p_z465E9qwGrq7w9O9_9-4mWd>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3FDD18A0068; Mon,  4 Nov 2024 18:46:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Nov 2024 08:46:26 +0900
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Michael Chan" <michael.chan@broadcom.com>
Cc: "David Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, andrew+netdev@lunn.ch,
 "Jakub Kicinski" <kuba@kernel.org>, vikas.gupta@broadcom.com,
 andrew.gospodarek@broadcom.com, "Paolo Abeni" <pabeni@redhat.com>,
 pavan.chebbi@broadcom.com, "Martin KaFai Lau" <martin.lau@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <319eb538-4b7c-45e9-b0ab-01d5ffdc097e@app.fastmail.com>
In-Reply-To: 
 <CACKFLik=SE4p9gq8BZJY68W_9QB=szU6cAwd-UgsvnCxQ6yu4Q@mail.gmail.com>
References: 
 <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
 <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com>
 <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
 <CACKFLik=SE4p9gq8BZJY68W_9QB=szU6cAwd-UgsvnCxQ6yu4Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Nov 5, 2024, at 2:21 AM, Michael Chan wrote:
> On Fri, Nov 1, 2024 at 3:42=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>> On Fri, Nov 01, 2024 at 12:20:44PM GMT, Michael Chan wrote:
>> > Thanks for the patch.  I think the original author Vikas intended t=
he
>> > user to do this for ip only filters:
>> >
>> > ethtool -N eth0 flow-type ip6 dst-ip $IP6 l4_proto 0xff context 1
>> >
>> > But your patch makes sense and simplifies the usage for the user.  I
>> > just need to check that FW can accept 0 for the ip_protocol field to
>> > mean wildcard when it receives the FW message to create the filter.
>> >
>> > I will reply when I get the answer from the FW team.  If FW requires
>> > 0xff, then we just need to make a small change to your patch.
>>
>> FWIW at least my HW/FW seems to behave correctly with my patch. I did
>> some quick tracing last night w/ a UDP traffic generator running to
>> confirm redirection occurs.
>>
> The FW team has confirmed that ip_protocol 0 will work as a wild card
> on all FW supporting this feature.  So the patch will work.
>
> But I think I want to eliminate the l4_proto 0xff usage.  It is
> non-standard and non-intuitive.  So we should only support l4_proto to
> be TCP, UDP, ICMP, or unspecified for any protocol.  Thanks.
>

Thanks for looking. I will send v3 that rolls up all the feedback
from this thread.

Thanks,
Daniel

