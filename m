Return-Path: <netdev+bounces-227100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4ABA84A1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AB61684C8
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E92AEE1;
	Mon, 29 Sep 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZQIvOdPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168D2AD16;
	Mon, 29 Sep 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131972; cv=none; b=iGdX0xoVVduvraG/Bpxz8j5ALykV1tJI5YBSfC2obsJrctoKmlzQ58V5KzOC+gwNFU27L2asdrySDkg40VftI2w/WpGQ8QBG/BpSnXO+8EK/Zb4TOtpP3fLmZPt1lGN6V68fJxHWBRfOv2LTs6I5k8EBFMHg5LlPJNLo+2/HJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131972; c=relaxed/simple;
	bh=zyXlfmidRAM1ua1ng8Wkw3W+HAJOLmaX8U2jJhQxs6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jni947wJ2IAI75M3InxnpCzdAH7erb5l14zn6ljg9fFllVQ9ciau3G4Lr3NAZ7OnQ4thhsLfxZBrUo5fkC3eML4WAxyIfuL0hWV2oUfHHFkkFxY3F2ZYCtzfJAw+c9bPOMwQsqoJ7dnfGqTUVtzu2GwaKPE9W8iWzEkAoSV/xJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZQIvOdPR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C7A06C8EC65;
	Mon, 29 Sep 2025 07:45:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CE6D606AE;
	Mon, 29 Sep 2025 07:46:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 673B1102F183C;
	Mon, 29 Sep 2025 09:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759131960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r5PWs7B59tRb4M2bO2nxcrF0rvvVbxQdUU3EETzQvU8=;
	b=ZQIvOdPRiS28WneCM/jUw0bI25tnniX1zqCjbXrN6ez7wh8pBSCTHDutI8juEQzvZIaIVR
	tlFZpUi8szUikhfwzKE67XslboIzOeSfgiJqMKz1byo+VBWnRD07G2/peL4N6evxnJtu9r
	kgw9oQljy//skWfINwr7vAFdSk8Ucz5MiwfpTV72eLGUuVcKgpgXvmsxkAUJePtJYUnIgk
	Uor0ddmfE1BeGviy3S5z32mA0KSYkGx9f8YEOiwhW1J7GodDpnzphpIzhmqNqRxQQ8z/jT
	NMtaSuoSV4C81QnYDjVZcFd+zSEWhEtJnZqZ2ihCTRu8EGi2ayp66cHnfZoNDA==
Date: Mon, 29 Sep 2025 09:45:52 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: wan: framer: Add version sysfs attribute for
 the Lantiq PEF2256 framer
Message-ID: <20250929094552.5f035bca@bootlin.com>
In-Reply-To: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
References: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Wed, 24 Sep 2025 17:06:47 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

