Return-Path: <netdev+bounces-131129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EC98CDB0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BE5B213C0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57318193425;
	Wed,  2 Oct 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l7HYjP9L"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A17DA83;
	Wed,  2 Oct 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853804; cv=none; b=S/WtpdA8yrsYs0ps8LkOnZTGM6Prt2p867uITMxxkHBvTlLm9g9wU8rEsDcTClSwciy8f6BVJHAF5OlLKpOc9COX8eyjLE6EXbn2S0KBo15Wxqpk7TBuR8a1qLAb0+ggW/3K3U6tyxQ5+di3l1cQvNu3gDQdPY3Kg4L7JPImiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853804; c=relaxed/simple;
	bh=v/JsmgYHZ0QZflFO/8dIx4JT1Rt4PWDgRjE+Ml0744k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyUGxE57fGPbb7n64qpP8sfi+uuymjDZ1Jnuc6SjdX4TDe5GzZJIYytX45C/hVR+fkvJzt2P0Ut7/VTJMZs6VhkNVzFNqIuSpR6BisKke8Wx2Ig1IQUzq00h14f8soyoiZL0aLcnxxEEkhiFSyfna3TdmPmjqVNrv9srJ3Gedfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l7HYjP9L; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C739520003;
	Wed,  2 Oct 2024 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727853798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URBZnfYXBr3w0BrNDgW2Uw1CIpmITZZkiZ0BXZEhFBU=;
	b=l7HYjP9L9vW8GecevkzN835FVlCusRzmQTgoFcrQB00Pp7YvHCn7RNPkUuY5B3+IBMPu6D
	I7j6FbvDGNkbX2AbxCLkXMrgH43WsmlvXoCNiEx+7Kou7D7mp1E0KOcmLCuLQQnEI7PVEb
	k1JJmWGdcl5UgLFqzeagoWDhNLUdiypOAPAvMvNsVWsfR3htBbY+XzvwsnJ+kSkIEU5nZM
	OZNtwhLCxrx9b9ZnCg+TJKppmaOBIxZX5pOwqNU1b77XHAhMvnY2f3wR58WPPVNvvxVYWc
	m26BweqHM2RMUhgA9CxxSyA/BSWO6Anq2//QikSIdTU/hiE1vdJ4IcsKm9merA==
Date: Wed, 2 Oct 2024 09:23:16 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 2/6] net: gianfar: remove free_gfar_dev
Message-ID: <20241002092316.3ac9f37b@fedora.home>
In-Reply-To: <20241001212204.308758-3-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-3-rosenp@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue,  1 Oct 2024 14:22:00 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Can be completely removed with devm.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This looks correct to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

