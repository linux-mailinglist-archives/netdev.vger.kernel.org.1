Return-Path: <netdev+bounces-279276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JRsM+n44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC274191AF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4B22300A7ED
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE03AF67C;
	Fri, 17 Apr 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="SLxy8ec9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D463373BF1
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416693; cv=none; b=VLhPDsW7b4l706212/FHYVBnUBmsdSNGP0Xn2kx68lbk4vQqosWY6pgsiPqqcuJ+SMCxbOZ8J1VxqwkwCEkCNhUwIGGrGThm/lOBFdu1QHkz5CrbNJkfRPdJ2zbiUJaFA0sNec3XtYJ1PEdVbyoVY2RcdTFP9fwZSsQOvhwyoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416693; c=relaxed/simple;
	bh=FmM0VK6S+YWgT44BaF54VclA8q7Qt04VtvovF5f5/bI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ayaqq6QeXm63pd9gvIQisMPjXfEEYgpevQOyCNtNyY0udGC0plgvMPpNr8DsJKEp3J/Y8T4K5hdvuUL4on9ypHY/imzN7pTscJ7xeLk7pcxbUX3Aself6qsybUiiLVdMIp72VLBXUWun435hiVUhr4DQpXz4QVp5+JbMHS/TwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=SLxy8ec9; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id D65E18EE;
	Fri, 17 Apr 2026 10:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1776416067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmM0VK6S+YWgT44BaF54VclA8q7Qt04VtvovF5f5/bI=;
	b=SLxy8ec9f5UCmbV57zhJkOi8EVyp1CjCVhdWrovJhOHwaf/1nVNa9aZWqlBXkPX1d/NPaD
	SAkyabiB5hDoZCmaPOIJYccBizct6cbOuVAuvZjsmkCIQ6VL7pT+BnPc67KewApegsta6Q
	JSgseGvTVEDi02VkSpyZmoHDd5+eMNyhtKIOI1sJFum4RpbzrwCA1i9AIbbY5y16xeF9kp
	aWqYJkM7fKOeDNJogajiNnFwtkNbx/IxJEVkJDWQDMNdtP2WZePiYX+wSdBDQEizeYJjhx
	7Q224mHs4wdXvtkJATlXcfK4ds9keZ71LO21X+l5/n9NYrJha5TvSlWrLz+Z0g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1cfd059d2923e634150b1c0ec5ab6699770978ef65260439d9432ede58b4;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Apr 2026 10:54:24 +0200
Message-Id: <DHVAXU7E031H.1CPZZA6ELD2DN@walle.cc>
Subject: Re: Path forward for NFC in the kernel
Cc: <netdev@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Jakub Kicinski"
 <kuba@kernel.org>, "Michael Thalmeier" <michael.thalmeier@hale.at>,
 "Raymond Hackley" <raymondhackley@protonmail.com>, "Bongsu Jeon"
 <bongsu.jeon@samsung.com>, "Mark Greer" <mgreer@animalcreek.com>, "David
 Heidelberg" <david@ixit.cz>
X-Mailer: aerc 0.20.0
References: <20260416101041.4c533306@kernel.org>
 <9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
In-Reply-To: <9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[walle.cc,quarantine];
	R_DKIM_ALLOW(-0.20)[walle.cc:s=mail2022082101];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hale.at,protonmail.com,samsung.com,animalcreek.com,ixit.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[walle.cc:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@walle.cc,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CC274191AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--1cfd059d2923e634150b1c0ec5ab6699770978ef65260439d9432ede58b4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 17, 2026 at 9:18 AM CEST, Krzysztof Kozlowski wrote:
> Does anyone knows if the NFC stack/drivers actually works fine? Did
> anyone test actual devices?

I was working on a product which used an NFC part from NXP. We
started with the upstream driver and libnfc and we did some
bugfixes, that's also probably the reason I'm in the loop here ;).

But eventually it was decided to switch to the libs provided by the
vendor, because that at least somehow worked reliably (and you'll
get support from the vendor).

-michael

--1cfd059d2923e634150b1c0ec5ab6699770978ef65260439d9432ede58b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaeH1QREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+Ng3AYC37NFsLTRp+oQpYGTywzWqPXqVKOq98/tE
yRNqxbg279zK70dPW/riE1EuRy/MiZsBf3bV2e/P3qrDKd0FChDzWeb3UPJsfMbS
7drv9oGPmpeT0IgcdT+JvZlHc6XHbb9zcQ==
=emZD
-----END PGP SIGNATURE-----

--1cfd059d2923e634150b1c0ec5ab6699770978ef65260439d9432ede58b4--

