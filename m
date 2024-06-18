Return-Path: <netdev+bounces-104641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920190DB37
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428BC282CA9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3C13C8E5;
	Tue, 18 Jun 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJQyYsjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124B1BC58
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733768; cv=none; b=f9stQFtpYOaCF9MdXo/S5IRaoyRo7zTwwSXMFao84+Vx0LdtDkWhBSBLsTTjd+7AOsjfGaWujtT9JgiFsMZykTXMf/6H2DRNdrxUj71oZREr/MGWRTrz+0sbIT9376Ireyyp0jHh+6IwPPMCcOG43QSaNULvRnJws8nzRd89jOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733768; c=relaxed/simple;
	bh=jCFdHvshc1E2UY/KIZ+hNQLolSKs6dMqc1eXmAJQHLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tux6UT+YQ3gJ4olUKJPUFPZ2uHX7dBngJxGz+hVVFsrRAtfEwUcmUf0Pg+fLsvU1LtAwKoE31uqrJmP+rajjPUH/w62TnCC7KXHec3cywyVb0SoulLwp3Ypk3uMkuqIveoYt5ei4C9+xMm25HNKGe9fqrPQbbPJHnMVrV5eEzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJQyYsjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEF0C3277B;
	Tue, 18 Jun 2024 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733767;
	bh=jCFdHvshc1E2UY/KIZ+hNQLolSKs6dMqc1eXmAJQHLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJQyYsjSuoECmCbecViBez8khOnh/ISXe4s+MPjdIo4tuzJrDqxA9Kjp1q1zPulj0
	 FEobJ9nbBVooqlrFLn9jLHtJ+8qqCZIA+Ox40ZFjRmoPouy5XYrbR1RyVD/nhAxExw
	 mouf3zAQ9s9HArJLzl9ab50Fc6VI9h7XOebsOBIgDHWSmhV8osxs5K6V4lM3HyXSTR
	 WEGe4LlfytmD6iMnuwp2UYetMYjruNWeQwtOPRAnVY7U9ROdcW9AsLztutanQHLVdZ
	 NrKeWbJcnKsFx+ffSo8mzyH9SYTWPf7wajvIkVW8qFDeWA/87UwkbwnAqLFtk+6OIg
	 hsbS3YtrdmW8g==
Date: Tue, 18 Jun 2024 19:02:44 +0100
From: Simon Horman <horms@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4_en: Use ethtool_puts to fill
 priv flags strings
Message-ID: <20240618180244.GT8447@kernel.org>
References: <20240617172329.239819-1-kheib@redhat.com>
 <20240617172329.239819-2-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617172329.239819-2-kheib@redhat.com>

On Mon, Jun 17, 2024 at 01:23:27PM -0400, Kamal Heib wrote:
> Use the ethtool_puts helper to print the priv flags strings into the
> ethtool strings interface.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


