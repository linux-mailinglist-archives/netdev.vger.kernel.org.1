Return-Path: <netdev+bounces-88916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D68A9024
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201111F21C9B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03C7A40;
	Thu, 18 Apr 2024 00:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from af106.secure.ne.jp (af106.secure.ne.jp [150.60.154.254])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EC503A94A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.60.154.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401250; cv=none; b=usY55CT5ZJzReOSljSCW3cNiqwjHzjsk5EEkA5/JnTaT0lbGG4M7vWTIC/GxE9mROwPFXUXwz7bR/Ukl9JoL/MxvJ2WtiuqdzsIBFAU2zBapFm+CK7qgubMfnRIoescgIQ9g33vy53/84xsdSxsBVQ9XoQk+8sevrGK/ZMFZ//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401250; c=relaxed/simple;
	bh=F68qRRW+ALbNyIFTYUzwb2+elVdi2YPotpPVQAtQ4/s=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=PDWLNjlUByVPj2PpshTRYBswIgb6f39ll5OctSBSxRUsjO/Itzy9qLhjS5uRxetNqZebL2TZEREmo5DzPKQ5h+hGQp7Yn3vB0rlle1rHhtr4HNecTJF1ar0d1/t5zSp2t2H8FHyHVTBicrolhSmxOyI2JHB/fU3Ln4rMDI07hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ntm.co.jp; spf=pass smtp.mailfrom=ntm.co.jp; arc=none smtp.client-ip=150.60.154.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ntm.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntm.co.jp
Received: (qmail 10347 invoked from network); 18 Apr 2024 09:40:45 +0900
Received: from unknown (HELO massives) (yo-shimada@daito.co.jp@194.5.83.22)
  by 0 with SMTP; 18 Apr 2024 09:40:45 +0900
From: "Debra Grimm" <angel@ntm.co.jp>
Subject: 2023 Extension Filing
To: <netdev@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <debra.grimm@visionaryhomebuilders.org>
Date: Thu, 18 Apr 2024 00:40:44 +0000
Message-Id: <18432024044000C02E051F3D-183BE2F6D6@ntm.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hello,
As tax season has come to an end, I am hoping things would have slowed down 
with you and you may now have availability to do our taxes...? We now have 
all our tax related documents together; We don't owe taxes, make estimated 
tax payments and usually apply our refund to the coming year.

If yes, when can you meet to go over our taxes? Everything that I can think 
of is ready.
We are pretty flexible and not in a huge rush as we already filed for an 
extension, so let us know what works best for you in terms of modalities.


Kind regards,
 
Debra  & Richard Grimm


