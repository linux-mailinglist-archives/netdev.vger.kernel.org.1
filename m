Return-Path: <netdev+bounces-236987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2BC42E90
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1A594E29D5
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A620010A;
	Sat,  8 Nov 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/avrUew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5971DF72C
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762613386; cv=none; b=pQnXsMmzCsh+7gNYj8BiRVh/QjVruVu0serNqVCo19FLhk1WZoJzgVHeGHaa6LJf1EpFRUx/j9iPrM5a+BrCHfwrXzK4pGLUw73tQ1wb92UjO93MMcvTHHAaXZnnb/iXtVj6lwKfRizxvyjfIaHLFW/wAo8bY0OXWv2WL3oNNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762613386; c=relaxed/simple;
	bh=1qg5xHB+nfsvZ/YDPOXzqun0wcu3deUA7lnrXuhvV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY7I67y+EzzbdhjB+gOK3SXwrpTgr3awyP7ync0fQ2Ged/8CplrQOtgCc1xSi62GwIqgrNrh2//fV6nMTEUTQRlNU5BIkfMoUfJc/wX3L4CEn+eD2b/LbNfypFwyGfkbZWycwm7Peqz+BEHAKqLhWXGvbcEJDEcQEm3seKEw9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/avrUew; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477549b3082so15162025e9.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762613383; x=1763218183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4ff5VcmU3TU7OayGkuk1bQc9Z5JUweNP/HWBPOh5Pg=;
        b=d/avrUewndpTw+Duui9WHrEkTEsNxfWeabxwancDQ7ix3gUqRCeMa1/eevj2vz0dBm
         iouHw9L88hRi3WF0sqKR1iydY2d/5xW8AQUGPJIGS1B2xeY/bvqWyHgiF4y5nQdOlUHK
         SpoFF4qoywMa4B79YQYPQ9Ye0OTCzS3BHmy1aLTT45ag2H9YPmjEEH0Os+Q76ifJOvy+
         RWOguPKUmmzncuTKbsg5/iIrBHwjtCHssuOTltCZycjwKWZvZ97N5OhWhOGQJ8l+Ejl+
         cpWjYIRq2vIzVVxL3D+4/LD3FEueZP9eEPxdd1I9HUEecoWuQc2jwaPNYiT2pW04tJq2
         PR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762613383; x=1763218183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4ff5VcmU3TU7OayGkuk1bQc9Z5JUweNP/HWBPOh5Pg=;
        b=RMN9SK8lpfLpELgqVdNbBFTDMym9G0kzrh89nTlKZSGM4sqy38pGjcE3tFj8Zcv0Nr
         KTff8KOCkcT6o5CaiDvChIWe0jUGnmI55w1dE1UFu7nV0g8B13sn0+zs+PwBJyAAXGE+
         nBpWCFeXjN4H5B3+Gao88EQdhwpCDZS3X7IIrfOzDY7iFzuhBVTop8FLUk1KS66euJ+O
         xS9us2lE5wzLl1MDc6cV/ezMygPfvGMASPEk9VgQSX/J59XU4TVvqTKWEkjAfkEY0ziV
         CVFk7d5d3KoJU9egdX3E8vuFU1bsHC5RxcYbbm7zCah09CfCHskqAQYXSKOunREfyiOX
         yntw==
X-Forwarded-Encrypted: i=1; AJvYcCUPHH+i+aTEz0+DA11Vmvir3gHpID0HIJsRatnLNVfTAkmbqsYBF2M60bJfJv4xftku4pbLOLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz29bzHrp/s8XIxV1h8vWzfPEMWwClXLKtSvw8JBdkyOooJmUj
	QFwKdQR6im/DLh2/I4+dxsX7tnnE1Zwm3pKxQilUa3a30QyP6o6aXeDn
X-Gm-Gg: ASbGncv2OgVXMED6/Wdw/zw/SnwzvOFIgK8/5V95kXpJ21nlReFQxYvObh8RXNA4FfP
	SKYmJGBLUOQ9ixS5Vw7OwEVMXlUQqvgCgFzJHyxeTHFA/xJvx8okcm5TdjuLC55gDBs02UMAtVQ
	pEuManR+lntCVG2bn9b1d3hKHJ6AqDR5ekXfJCZ5wDg0j5G1u5ughcTGpSwF5d1AeNay47xz2u7
	kFmDk4YlFj9OtY5k6Cp/qHqRQnmQGrQ1Ep92WMxEL3Wpgyh36mFGv4jZW1nJ/jC6A6UvUGvoWgU
	ZCbOrJiUQhCuRoUW3n2nW7q2S5m5dTUfxnS9HR4nlNAqV5y6MPehtlSq6lm6gYfQU2xKsiJi/uC
	6uGEAIXrbh5+1ICbzZCgtqgafFRxUtFvUZWQERqC3TJhv1XffQSip1gftwLmJTn2HOCfc3sFzjl
	lYT7ScM6NehScwRGwxAWW/seH73syXn7MDGVeXiwkv1JqlxAUFcb5fD8g=
X-Google-Smtp-Source: AGHT+IGydhhnshsez8CN8u1LX2G3/DoXSvva/5h6RN82FBeD+H9WCO0u3sOvJvmAtBnf+0fs2vK1Kw==
X-Received: by 2002:a05:6000:18a3:b0:429:8b47:2f35 with SMTP id ffacd0b85a97d-42b2dc23fafmr2404180f8f.26.1762613382340;
        Sat, 08 Nov 2025 06:49:42 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2e96441dsm4401402f8f.23.2025.11.08.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:49:41 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 77A82BE2EE7; Sat, 08 Nov 2025 15:49:40 +0100 (CET)
Date: Sat, 8 Nov 2025 15:49:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: mc36 <csmate@nop.hu>, Jason Xing <kerneljasonxing@gmail.com>,
	alekcejk@googlemail.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	1118437@bugs.debian.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
Message-ID: <aQ9YhCAdu7QNyYxu@eldamar.lan>
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
 <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>

Hi,

On Tue, Oct 21, 2025 at 12:51:32PM +0200, Fernando Fernandez Mancera wrote:
> 
> 
> On 10/20/25 11:31 PM, mc36 wrote:
> > hi,
> > 
> > On 10/20/25 11:04, Jason Xing wrote:
> > > 
> > > I followed your steps you attached in your code:
> > > ////// gcc xskInt.c -lxdp
> > > ////// sudo ip link add veth1 type veth
> > > ////// sudo ip link set veth0 up
> > > ////// sudo ip link set veth1 up
> > 
> > ip link set dev veth1 address 3a:10:5c:53:b3:5c
> > 
> > > ////// sudo ./a.out
> > > 
> > that will do the trick on a recent kerlek....
> > 
> > its the destination mac in the c code....
> > 
> > ps: chaining in the original reporter from the fedora land.....
> > 
> > 
> > have a nice day,
> > 
> > cs
> > 
> > 
> 
> hi, FWIW I have reproduced this and I bisected it, issue was introduced at
> 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.

Just a qustion in particular for the stable series shipping the commit
(now only 6.17.y relevant at this point since 6.16.y is EOL): Give the
proper fix will take a bit more time to develop, would it make sense
to at least revert the offending commit in the stable series as the
issue is, unless I missunderstood the report, remotely(?) triggerable
denial of service? 

Or do I miss something here?

Regards,
Salvatore

