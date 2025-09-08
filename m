Return-Path: <netdev+bounces-220747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC69B48718
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2983D1B22A30
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3A2EF669;
	Mon,  8 Sep 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HxsjMQP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951302ECEAB
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320069; cv=none; b=dzNTJLyFul1vw515qQz4xh/ogsRQDv87tmOrnncNr1B+ivCCmK1JYJ7gb9OxKwNuKcqKibrbg4ZTqt5by2mkuAkEy84C4xQ/P9nswCnjYh28S338rZa7agMlQPGELLp9i/irWBFBYz5r/KKNYmWPbrEmWch054Refzz41XkVJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320069; c=relaxed/simple;
	bh=6ffU6EUZfBF4SIZFIFeAxQS2ganb6B9lq3MegA8FFVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1eH8nFyfmbjgs/ud8LcSB5VpN0DAn1MrAOESS/mUjpM9clxtYWIuq+MVVIRqAhPqnsPAkgnJ0sGHPHQDjoP8tpmlt6BM5JOkJr6YSU51Op6QjCmWfdf1ZXGzvvS3xZeFj4co2eDVphG0cOgjE1XfMmRRHyJMFwbAMe73faI8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HxsjMQP4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BB1F1C8F1DE;
	Mon,  8 Sep 2025 08:27:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 420EA6061A;
	Mon,  8 Sep 2025 08:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08E98102F2897;
	Mon,  8 Sep 2025 10:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757320058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6ffU6EUZfBF4SIZFIFeAxQS2ganb6B9lq3MegA8FFVA=;
	b=HxsjMQP4pBFNlXI6uWrzS3BfvFG5G8vTB/KaCJ+5ctK1Et7ao+82lPOJiEdFAbfOIxEyRI
	Abd659F9FLZseRMQy2gwkmu7cNHZqID1ffTxfi9F4xwn5wreBi7NkzHOtGa9oPIGVdaDl/
	ghHXMVcF7MO0Xg1alFLnu1KFuJoaQzCMcFbTwn7zzyGYcoBlut+D4xPKxaZgwoCUYd4kpD
	6IH0ajJJrmopKpeYSd3NfZByzOvXh9BiMiiqjFZ94gW5U11yuqYGY2vAH8NZ1CMdL6OH2c
	hosINYbcOrEfrOGBOyOBK8XR5N2RGssI0p2KjROB7QhEt1Q5mlNWYRpl5NP0wg==
Date: Mon, 8 Sep 2025 10:27:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandra Winter <wintera@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Shannon Nelson <sln@onemain.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
Message-ID: <20250908102725.10b368e2@kmaincent-XPS-13-7390>
In-Reply-To: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
References: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 07 Sep 2025 21:43:20 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> In C, enumerated types do not have a defined size, apart from being
> compatible with one of the standard types. This allows an ABI /
> compiler to choose the type of an enum depending on the values it
> needs to store, and storing larger values in it can lead to undefined
> behaviour.
>=20
> The tx_type and rx_filters members of struct kernel_ethtool_ts_info
> are defined as enumerated types, but are bit arrays, where each bit
> is defined by the enumerated type. This means they typically store
> values in excess of the maximum value of the enumerated type, in
> fact (1 << max_value) and thus must not be declared using the
> enumated type.
>=20
> Fix both of these to use u32, as per the corresponding __u32 UAPI type.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

