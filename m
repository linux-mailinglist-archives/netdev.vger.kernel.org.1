Return-Path: <netdev+bounces-133705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D3996BD2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B701F2818F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C21196C86;
	Wed,  9 Oct 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlXK1dPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168318C92A;
	Wed,  9 Oct 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480415; cv=none; b=Sft6InhPz6XTykRatelxFoQLOVFSOmJtsyuB7+4acbBLg/bk0E9AiKgTBL+FxFI4C8DQZRvKIElHQuJFXNqv6Joa8MOYd/BTuUe/60Kt1u0NvIBQwtNZyL1NNarLKHcXzz0aHGrtKR/d/CbpiY22KOGRtQtfxS2/10AsrS7kpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480415; c=relaxed/simple;
	bh=PN6f09F/iXPcUuFseEbKw1CovPcR4LB4xjUUzQe7PxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npZrDM3QUlSxLVg1aP4vL7ANhwhH8OR+PET3WYg0qzQFT2L0eF5q5hjnPa/ebeCpaklxDRDC22T0zLYR9P4PsZLY/CLsQqTiRITnwPEql0hEo0aL3rhKdoaHBqGh3GQQWnGjFcRYJDXIm+3rccJCNXg3tt6+N5od/8xg7CYAJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlXK1dPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C970AC4CEC5;
	Wed,  9 Oct 2024 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728480415;
	bh=PN6f09F/iXPcUuFseEbKw1CovPcR4LB4xjUUzQe7PxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlXK1dPSZW0N/kZ+6/iEAYetRIXiMmW6SJ7bnGEK6gD75m1U8DdkllGO/QRrYbkzK
	 kGKtL/oCr6e6g60aGOxqiTEqe3mIbCQax2OYwU95aIn0q6zpTZZktTszvRhkFp6l4D
	 r35h0HyQuvgVKJwLGWVFR3k0rVSxYuce5eAhI01rufsKcP7AKftD9nonzfeRGhfLaZ
	 HBTQ6VNACo6I1e1MOvkRpApceD/khl8kjAak7hRAdKvloWHrTfHucyBmD8ZPAOrpf9
	 kP7pzqlTcMBgzTlXNZlfNh99lcQ88ddRuc5Km1lTdi5ZI0q3IaR/tePwZtMjPt8JL7
	 2zRG1/BSclpzA==
Date: Wed, 9 Oct 2024 06:26:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jdelvare@suse.com, linux@roeck-us.net, horms@kernel.org,
 mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v4] eth: fbnic: Add hardware monitoring support
 via HWMON interface
Message-ID: <20241009062653.79fb9c36@kernel.org>
In-Reply-To: <20241008143212.2354554-1-sanman.p211993@gmail.com>
References: <20241008143212.2354554-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2024 07:32:12 -0700 Sanman Pradhan wrote:
>  	if (!fbd->dsn) {
>  		dev_warn(&pdev->dev, "Reading serial number failed\n");
> -		goto init_failure_mode;
> +		goto hwmon_unregister;
>  	}
> 
>  	netdev = fbnic_netdev_alloc(fbd);
> @@ -310,6 +312,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>  ifm_free_netdev:
>  	fbnic_netdev_free(fbd);
> +hwmon_unregister:
> +	fbnic_hwmon_unregister(fbd);

not what I meant...
Delete these two lines and leave the goto above as is.
HWMON can remain registered even if we don't probe networking.
-- 
pw-bot: cr

