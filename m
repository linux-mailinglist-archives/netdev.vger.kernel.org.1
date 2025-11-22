Return-Path: <netdev+bounces-241045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE8C7DDAD
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 08:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75E674E06E4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223CA22D4DD;
	Sun, 23 Nov 2025 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuzy.me header.i=@fuzy.me header.b="DZshyZvN"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3A21ADA7
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763884062; cv=none; b=KLm7f/oZJHIr2uLjwlNgCfLUmq24bYhy/Cvfzaj10KHDkrpaSbjxGfA6c3D5rcS70L5sYm9y4HE+P4msHzBXsXwJtVHXRz2zfJQ7FkW+YRTHZitQ6+WlGW2EOYkSh6GaBIvhMM6K4eQngFzLAPgvyg6jS6bVsw5euSZuBdXQ3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763884062; c=relaxed/simple;
	bh=GV7jUVlcmHo2BO0jAqLMSvTlMN+LB9PLVIMz6RsOidE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VUsFmnwNmYRJzE3KqhmxMOTeaRwnzAJupgmOTprL312jNc1dBZaPkra6Rl9ERxH1JauvmFhhVypKsc4BXF/37o4VlA1YW6mnwSyyuUKKfpQJD6AkSvXHShudUjlNCUeY1iTlvK3aP4BU/vtaG45ap1dHx3Fg/jJFLXeAmlSFpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuzy.me; spf=pass smtp.mailfrom=fuzy.me; dkim=pass (2048-bit key) header.d=fuzy.me header.i=@fuzy.me header.b=DZshyZvN; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuzy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuzy.me
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 55B05581198
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 15:49:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F917438CE;
	Sat, 22 Nov 2025 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fuzy.me; s=gm1;
	t=1763826542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp/cjSb4vT5QjkXnw3HP+GJTrF3NLjE10Gq9wwuMSe0=;
	b=DZshyZvNY1UpR8/o99iL/rHTGojmXDmbmuci79id4MzL0dp7LrjblwYKX7XLMTOsJDCh7j
	GjibWNkuGdI3cpaqQqQ8i3x3gDp6e9Kqr6Iu0w8I9kxHa4HVK+g/TJThrXpuR5ahiRdjv4
	x2c5WGcZDOsRCJxFB92n4xXNFjqSDjfmAJKlBVq8qpY5EPPK5/3MBuQpRcPBz30mR7I1iA
	ofWpL1gge/GDorp6YHrtJHDV0Il+s63ixi06N+7oIuacMUODwPOHNyjKogaD31ctBgPnoP
	LTxIKgpQXJhA0GM9LxxcX6uh8CGkR71FGKNgHTB9DPf5NHERevCt33UBmLoJhg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Nov 2025 23:49:01 +0800
From: Zhengyi Fu <i@fuzy.me>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] iproute2 - ip -d -j tuntap outputs malformed JSON
In-Reply-To: <20251121161007.4c7ebae6@phoenix.local>
References: <87jyzkvwoq.fsf@fuzy.me> <20251121161007.4c7ebae6@phoenix.local>
Message-ID: <056ab09af752720634a16a24a5b03f26@fuzy.me>
X-Sender: i@fuzy.me
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthekjhdttddtjeenucfhrhhomhepkghhvghnghihihcuhfhuuceoihesfhhuiiihrdhmvgeqnecuggftrfgrthhtvghrnhepveetudeuffeludektdelvedvgfehlefgudffgeeuuedvudeffedvleegjeefudfgnecukfhppedutddrvddttddrvddtuddrvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurddvhedphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepihesfhhuiiihrdhmvgdpnhgspghrtghpthhtohepvddprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: id@fuzy.me

On 2025-11-22 08:10, Stephen Hemminger wrote:
> On Fri, 21 Nov 2025 12:25:41 +0800
> Zhengyi Fu <i@fuzy.me> wrote:
> 
>> Hi iproute2 maintainers,
>> 
>>     $ sudo ip -d -j tuntap
>>     
>> [{"ifname":"tun0","flags":["tun","persist"],"processes":["name":"ssh","pid":86812]}]
>> 
>> The “processes” value looks like it should be an array of objects, so
>> the inner braces seem to be missing:
>> 
>>     
>> [{"ifname":"tun0","flags":["tun","persist"],"processes":[{"name":"ssh","pid":86812}]}]
>> 
>> Could you confirm whether this is a formatting bug or if the output is
>> intentionally flattened?
>> 
>> Thanks!
>> 
> 
> It should be an array of objects. You can confirm by seeing the output
> with multiple processes.
> 
> Does this fix it?
> 
> diff --git a/ip/iptuntap.c b/ip/iptuntap.c
> index b7018a6f..6718ec6c 100644
> --- a/ip/iptuntap.c
> +++ b/ip/iptuntap.c
> @@ -314,6 +314,7 @@ static void show_processes(const char *name)
>                                    !strcmp(name, value)) {
>                                 SPRINT_BUF(pname);
> 
> +                               open_json_object(NULL);
>                                 if (get_task_name(pid, pname, 
> sizeof(pname)))
>                                         print_string(PRINT_ANY, "name",
>                                                      "%s", "<NULL>");
> @@ -322,6 +323,7 @@ static void show_processes(const char *name)
>                                                      "%s", pname);
> 
>                                 print_uint(PRINT_ANY, "pid", "(%d)", 
> pid);
> +                               close_json_object();
>                         }
> 
>                         free(key);

Yes, it does.  Thanks!

