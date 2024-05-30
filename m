Return-Path: <netdev+bounces-99354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23968D49B0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1F282008
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BB176ADA;
	Thu, 30 May 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="A3oGUuh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAF183965
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065098; cv=none; b=TL/5pxYcTW/Mnb82+q3jdpted4oYnIgsW8TR8ZQp5QMPFhozN/qJc6cw5PV7HXilGdb0ckT/TlfyjrI3tuFrJdFBhQK6DUZnEjJoal4/UZcb35I1DfwIB3wAJF+EiiIyBqFOYKf5lvfJAY8j0pLtsQbZ22mUItiFQHQEB2fOnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065098; c=relaxed/simple;
	bh=wKoEYE+ohBaiDXtYb5lctkM/4uGVLLJSFcncDkWj++M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJa8IQsNty09ysUUoD7+/RQwsCEnzkCJ57Ym7c+bqoU2F8/J2DQuNlloHMzoLl/e9P/7wCNI28CiKtxFGGVVPiYyb8axRGxTEbWIsqKyYKKGuy5BK/b3dQFlIVb2Qz0Yca0aKAFj2b9HOAIpWnafUsODkqgHB1om6iSEe0vqGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=A3oGUuh9; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3E8B59C2CD8;
	Thu, 30 May 2024 06:25:08 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gUsf3llwsj-w; Thu, 30 May 2024 06:25:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A421C9C59F5;
	Thu, 30 May 2024 06:25:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A421C9C59F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064707; bh=wKoEYE+ohBaiDXtYb5lctkM/4uGVLLJSFcncDkWj++M=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=A3oGUuh9Qo1M8KVAzJi43FzqQbNY5BakrAhxIRVl9fYiz7lGy2wvaN//9nckZyLef
	 TTAcXycPVdKgKnlrmM2bDjTg6hAYbtLgi7OikgqbxPaNm1H6WNKRWWeuofB4xXrQKj
	 QSt/FBmpJayr+fTaCemFx8iricM9mDe3v2slzU+k3GNJCIGzZ+GqV/C+/drUdTuDZt
	 n71A+7eVI5fZ839Yj28OgOZ0HGf6Nf/Ljy6qyL9MR38KYzfCs6JTMwMB2r5Fc+V2hp
	 tH4z79rC+NqgwxnWYJ24nuThLraBH59rizsuaI55oRm1Pu6xkQ3+wh1SqzsLyMuFFL
	 xxCNZQGQii+Mg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id f8IRgATIa3FR; Thu, 30 May 2024 06:25:07 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AE96E9C2CD8;
	Thu, 30 May 2024 06:25:06 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net
Subject: [PATCH v3 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Date: Thu, 30 May 2024 10:24:31 +0000
Message-Id: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Back in 2022, I had posted a series of patches to support the KSZ9897
switch's CPU PHY ports but some discussions had not been concluded with
Microchip. I've been maintaining the patches since and I'm now
resubmitting them with some improvements to handle new KSZ9897 errata
sheets (also concerning the whole KSZ9477 family).

I'm very much listening for feedback on these patches. Please let me know=
 if you
have any suggestions or concerns. Thank you.




