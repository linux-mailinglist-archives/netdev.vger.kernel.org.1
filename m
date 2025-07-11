Return-Path: <netdev+bounces-206072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365DB01428
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4A13AC307
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30C1E5B73;
	Fri, 11 Jul 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PvOKqHX6"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89D1E47A8;
	Fri, 11 Jul 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218102; cv=none; b=srBAtL+z0XYn3Bxw2Bxy9ongPJPJc3l8bJ6xi6r+2960FzlqV6CezfB0wchxVLm1gnCCLwUlaLkY8+ELSIapql+HWpGMJVYVcavCrskIRDNdP755QLNFkiNq2sT/V4L0gdBRuVw8A06eN+RnKk8AuzTQOD3116NvkoDsThO7+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218102; c=relaxed/simple;
	bh=Xi6ZPujqEF5WJgD2Lz9HdO5VrSb6pP+pVLOd+uyx8oU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fe/mqo5lO0+gZJmnCpa1ncUbxG1zurN78n4DUWN0/DQjiCFBlhQBPHAwyYIi5iMN+csGDcsizoRtUFYdFKI+U+l7DIHyg3Y8DZ1GJO702ARgE1tKO90lP2F1tZG34oBTYvrwiBA9xSrBqS0QiG+tHK1foaao7+UKONCti7J88Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PvOKqHX6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xi6ZPujqEF5WJgD2Lz9HdO5VrSb6pP+pVLOd+uyx8oU=;
	t=1752218101; x=1753427701; b=PvOKqHX6BWU4RT5oxVxGa5UxniSgyZy5u+TyN8TpEct6g98
	l/kd7E0WgUp2OuVljZHA82k+vQ20/XEe909E3pFqbuIPnREdt05Um30+UQC2bRuMuWjMzksCPBZgx
	yVdEu9+a7SSs3EP7rqHQCXbcK+upaDH+8QxKpcAlZzPfq/Gq/3jTeKA4OrZh2gSyzF27Flo5AkfJ6
	d7vyxR/i38YVTuTbsthgBUOGFiebKw4NVscgRwJ+t2rs3MzXLxRMnxTulGphfXwPGcXLl4HOnY9fX
	OPaHFiRNEeJZn9klx8bY7H6rngBrgCe2TM7aMEzrjr6QEke/DFL5MIcvYh9wXBhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua7y6-0000000FyRU-3Duz;
	Fri, 11 Jul 2025 09:14:51 +0200
Message-ID: <21d8f6388b98ec0fe8662606a3f1c3181466917d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
From: Johannes Berg <johannes@sipsolutions.net>
To: Shengyu Qu <wiagn233@outlook.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Date: Fri, 11 Jul 2025 09:14:49 +0200
In-Reply-To: <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
	 <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-07-11 at 12:37 +0800, Shengyu Qu wrote:
> Hello,
>=20
> What is blocking this patch to get merged? I'm seeing more 5G modules=20
> need this to work correctly, for example, FM350.
>=20

I guess I have no idea, fell through the cracks and so far nobody cared
enough?

DT folks, what tree should this kind of patch go through? I guess I can
take it through wireless-next with other rfkill changes? Or should it go
through some DT tree?

johannes

