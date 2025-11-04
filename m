Return-Path: <netdev+bounces-235348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB5C2EF59
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17E784E1FC7
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08E23EA89;
	Tue,  4 Nov 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbN+LWzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373081DED42
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223012; cv=none; b=UEKeiYYh17foN4DUURP/cADVpb6N/0v9myc3Mu/h5JJtrM8VsO4Tx7s9Si+ifRYH/dkiFJUUcZ9z3YCpIyZ4NpOt4n722Bqd7z7CRxmZ/wJtFB9QedkDRRMekxynw+5NAP61kl+pOB0C+bPoCyLt38H0MVzH4BsCwmXRBDAko9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223012; c=relaxed/simple;
	bh=0gKttlbwzRJVb8JbJG1raExFWBzQaIbBLz23P785g+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk+SC2Elt6/Wx1OANYHjuPLERD4RmTF2gY++bgnQyLiBkqSVj3t+AqXYZtjjrHSamQvtvu4OMJgnmCtKles+RkBay4ge2jgBLfMpel/vQDI+VU6E2EalPDeqj2bmAaw1jxyHk/yc24Nt/bABzRvba8Cg+OLjZPpVXuX3z4qXmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbN+LWzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4BCC4CEFD;
	Tue,  4 Nov 2025 02:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762223011;
	bh=0gKttlbwzRJVb8JbJG1raExFWBzQaIbBLz23P785g+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbN+LWzW7E5nzyDI5+rl3NTqe4Tup1lFYqt6zjhqZe1GYJEBjydWK2u+ps1H5uwJX
	 SV9jaxmRs6gvDVNCed9IiK4msIgnFUyvfHocJfTqBAyEyilPQI+z2jNWiVq4XO7MvX
	 Z/2btlwUyQvwCoexVHlvn5W19ZGLBuV+BSKO7cZKxgLJ7SaxA4NIqXXIXFbzOJBc4J
	 VLsLat6VD7Wi6+ZVQTr0+9o4Zvly13KG/+ITZr2QiAvQcPclUQyvXzLcSB8YgSIIuT
	 eWF4igKEhxNN+Jy88Ul+7tGEXUYJ89ukcfhiqwHFagsuY4PumcHb/GmrYTgrs51X5M
	 BkkXjvJnKQeGA==
Date: Mon, 3 Nov 2025 18:23:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 1/5] eea: introduce PCI framework
Message-ID: <20251103182330.4ba2e102@kernel.org>
In-Reply-To: <20251029080145.18967-2-xuanzhuo@linux.alibaba.com>
References: <20251029080145.18967-1-xuanzhuo@linux.alibaba.com>
	<20251029080145.18967-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 16:01:41 +0800 Xuan Zhuo wrote:
> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev)
> +{
> +	int err;
> +
> +	pci_set_drvdata(pci_dev, ep_dev);
> +
> +	err = eea_pci_setup(pci_dev, ep_dev);
> +	if (err)
> +		goto err_setup;
> +
> +	err = eea_init_device(&ep_dev->edev);
> +	if (err)
> +		goto err_register;
> +
> +	return 0;
> +
> +err_register:
> +	eea_pci_release_resource(ep_dev);
> +
> +err_setup:
> +	kfree(ep_dev);
> +	return err;

Please name the jump labels after the target (usually first action they
perform).
-- 
pw-bot: cr

