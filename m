Return-Path: <netdev+bounces-181282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6134A84469
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CC4A3EDD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8128C5D4;
	Thu, 10 Apr 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JyNeQbxg"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3528FFCF
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290527; cv=none; b=iZWaiDGewS+uP3ODvCO6zK1S2ahCsDDvId/3eFunX2DVTYhqCPEU2QtcyqwS9ZlXnXW6G7QwigDTQAQuCxaoKysSqH2oxtLtN1wcOKSO1KHLxH84HSUENHy7sm5ZDUR15Ycu3PKUTDAAxq8XEUdNETcRdqGjvo70ppWk8eYcaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290527; c=relaxed/simple;
	bh=UEVfVn+kRWXLw58hUFtaOx95aRUWamak2EmObPLAGaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwQ2Vn4hJ8rhiFen/pSSGca5BnmIyTqLc9Ne5KDwRkjsuNTy6nq/HTOMhzFeZDIPYG23I1bB7GwfLR1saBO7i5xIIdDaMX8PtfjNdW2vdgdeMEW+CW3T6OLQf2zDOwIALglr/8kfUlSC/lQ55HZP9x4Mix/VC8+2aonTWN4NOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JyNeQbxg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744290515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pnfe4fwyjClx3VajDxfmgLwlfvxavW9WEkk87ykFXUw=;
	b=JyNeQbxgUmHo6mnKTRmuIvJ+k9h1fRf30quv/HboHWJ8TLvklwbHHZ+E/1/DmG4PL+fhvZ
	pqovbd+WESgsn+8EsBSyWdSMBC9+YwgmjO9kOIvXj+OsuKNEQc269pIqtG+RKgPouifOYQ
	ecqEIDtdEQKSPyCfebtbdv2l8i9H8AM=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject:
 Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
Date: Thu, 10 Apr 2025 15:08:25 +0200
Message-ID: <3807435.LM0AJKV5NW@ripper>
In-Reply-To: <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
References:
 <20250409073524.557189-1-sven@narfation.org>
 <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17243847.geO5KgaWL5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart17243847.geO5KgaWL5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Apr 2025 15:08:25 +0200
Message-ID: <3807435.LM0AJKV5NW@ripper>
In-Reply-To: <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
MIME-Version: 1.0

On Thursday, 10 April 2025 12:13:25 CEST Paolo Abeni wrote:
> Also this is somewhat strange: the same patch come from 2 different
> persons (sometimes with garbled SoBs), 

Ok, all of that was my fault. Even the original duplicated *dev_hold. Just as summary:

* v1: accidentally submitted the patch with correct content but from a test
  git repo which didn't had the actual commit message
* v2: send correct patch but it was done from the folder which is used to 
  prepare the branches which will be submitted later by Simon -> git-send-
  email picked up the Simon's name (see below) and submitted it using my 
  mailserver
* v3: submitted it "correctly" and marked the day as "shouldn't have waken up 
  in the first place"

Regarding the v2 situation: This is definitely odd but it had to be done this 
way because there were complains in the past from netdev when Simon submitted 
the PR and not all patches in the PR were Signed-off-by him. As result, when I 
add something in the queue, I directly apply the patches as him (including my 
own Signed-off-by). And Simon will go through the patches again before 
actually sending the PR, create a signed tag and submits the PR. I would love 
not to do this preparation/fakery anymore. But then you will not have the 
requested full signed-off-by - something which you usually don't have for PRs 
but which was for some reason required for netdev.

> and we usually receive PR for
> batman patches.

This was just an attempt to get syzbot happy again (sooner). Besides my direct 
patch submission, we have different options:

* wait for Simon's PR
* let Eric Dumazet integrate his (earlier posted) patch from
  https://lore.kernel.org/r/CANn89iJTHf-sJCqcyrFJiLMLBOBgtN0+KrfPSuW0mhOzLS08Rw@mail.gmail.com
  This change was also published earlier

> Also I do not see credits given to syzbot  team ?

Correct. Is there a proper way when the reports received were actually about 
different problems (just the bisecting went the wrong way due to the 
batman-adv bug)?

For example, I saw the problem with bisecting in:

* https://syzkaller.appspot.com/bug?extid=ff3aa851d46ab82953a3
  Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
* https://syzkaller.appspot.com/bug?extid=4036165fc595a74b09b2
  Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
* https://syzkaller.appspot.com/bug?extid=c35d73ce910d86c0026e
  Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
* https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
  Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com

So, a lot of different problems which unfortunately all ended up in bisecting 
to the batman-adv problem.

On Thursday, 10 April 2025 13:20:21 CEST Eric Dumazet wrote:
> https://lkml.org/lkml/2025/4/8/1988

You also posted your patch here. Feel free to directly add it. And sorry for 
adding the problem in the first placed - just tried to make Antonio happy (and 
then created a big mess for everyone else)

Kind regards,
	Sven
--nextPart17243847.geO5KgaWL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/fCygAKCRBND3cr0xT1
yxu8AQDvU+PC2pRuTGWFrbC/EbBKa/jN3KL1G23sBsR58qDouAD+JG7Xo0+x8NGC
lUCspIoHiD2vSNx/5/ydaWuwQyM9cww=
=lh1b
-----END PGP SIGNATURE-----

--nextPart17243847.geO5KgaWL5--




