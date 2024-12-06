Return-Path: <netdev+bounces-149822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA959E7A5B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E8A1887840
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76B202C50;
	Fri,  6 Dec 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telenet.be header.i=@telenet.be header.b="R4CBPgKZ"
X-Original-To: netdev@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB9212F84
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519396; cv=none; b=NlzW0VRzvPBbGt8VnTcwFIpDmNScv6ssHw8Vsr/PEkIoEPPfAX9kAta9DDjJJx6PKSHkPsxozs09wxgfDqUgxolnJWjpWMuVrca2yQf0Umlkh3JDWQ9C2/elpmy6996/1/nBeH1n/Qlfo5uRtql66zFfAQpP2hxwC4c1rDT2aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519396; c=relaxed/simple;
	bh=NnfoURGNqGV4ItnHh7MeDJ+x6A8SXrC1x4GWhdhtDaw=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=JxQwXBPmGrAiL6yyn3pxLHJCEDJF4jC6fj9HaeV5usw23sHzvnZfpdohUYrCg9/uKCWwl9mzv/bOJX3dMkHXaTyEIrhwEx8skovMnD+L4ZwvkyTY2jhhPeHc5r+GYPzvoRpIyp295Kkc0UOfsXioBZPNUafFg3SfA+dS4C4PL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telenet.be; spf=pass smtp.mailfrom=telenet.be; dkim=pass (2048-bit key) header.d=telenet.be header.i=@telenet.be header.b=R4CBPgKZ; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telenet.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telenet.be
Received: from [127.0.0.1] ([35.205.80.129])
	by xavier.telenet-ops.be with cmsmtp
	id lZ9q2D00G2nQEWz01Z9rrW; Fri, 06 Dec 2024 22:09:51 +0100
Content-Type: text/plain; charset=utf-8
From: KATHY BARBATA <kevin.verheuve@telenet.be>
To: netdev@vger.kernel.org
Reply-To: kathy.barbata@fkrm.com
Subject: 2024 Taxes New Intake
Message-ID: <224643ce-e1aa-bdda-8669-ff07fa5250cb@telenet.be>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Dec 2024 21:09:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telenet.be; s=r24;
	t=1733519391; bh=NnfoURGNqGV4ItnHh7MeDJ+x6A8SXrC1x4GWhdhtDaw=;
	h=Content-Type:From:To:Reply-To:Subject:Message-ID:
	 Content-Transfer-Encoding:Date:MIME-Version:From;
	b=R4CBPgKZtQi7szojgltyHZTCAefxjNyupkaIHaL2a4RhxRlnpINrXy5B1RnESq3j6
	 Ite38vDTSJ3PghueEbBq9s9Gqz+vD0efnl4OMMOpKakMC0p+Fzr4BlWX/FD/+nx/aB
	 dl4C/6KpHrP1Cp4+BIbkuX2SpbU3BXDBPye9mhWpiRatPowNBXO/itR8Mmz8YpHudf
	 w3jyDuBcGzpV3kJ2pU04KrBgA1yOELA7ZLgWBHUWAJGhtRkCrM8OEQ9uq4GUPvu3mn
	 qWpa/0szETarAWdK+jQR53NkSDJWe/zzGoPe4Rbj89ShXHOt6Kf1CWCREw48ggy4/P
	 wZZGjhA9xPcDg==

I hope this message finds you well and that you had a wonderful =
Thanksgiving.

My name is Kathy, and I am reaching out to inquire about =
your services for preparing individual tax returns for the 2024 tax year. =
As a new client, I would greatly appreciate the opportunity to discuss how =
you can assist me with my tax filing needs.

To provide some context, I am =
seeking professional assistance to ensure that my tax return is filed =
accurately and efficiently. My previous tax preparer has retired and =
discontinued their practice, prompting me to seek a new professional to =
handle my taxes moving forward.

Could you kindly confirm if you are =
currently accepting new clients for the 2024 tax season? If so, I would =
appreciate guidance on the next steps to get started. Additionally, I would=
 like to know which documents or information you require to facilitate a =
smooth and seamless process.

I am happy to provide a copy of my 2023 tax =
filing for your review if that would be helpful.

Thank you in advance for =
your time and assistance. I look forward to the possibility of working with=
 you.

Best regards,
Kathy

