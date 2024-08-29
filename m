Return-Path: <netdev+bounces-123037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C8996381C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF51F23FA5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4122BD08;
	Thu, 29 Aug 2024 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px57764e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15029424
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897710; cv=none; b=frAm9E0CD62lyH/cul6KVw3bQ/QXsy8MdlzKEsMx5jnT/ib7oz950s8CADdabsEupIs/X3tNYF411gmaHS2S0i8Rjv+eZnkR6yyT/JM06xyJ7A/MTQ391f4BwAuKVUh25sMJPQwvFwHfxQRge0bTTGO+z6Xo1MsK1eLmXE93DsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897710; c=relaxed/simple;
	bh=zVO/Ah/BvSf6XOZ+ooFRuP9AdsTAqFkEN+fM6Yvfmhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b39XJl5P2ehzv4nRImc/ohkgcMc//Jk6cTXbIrW08d+eeMWvti5elD073mbzcW8OjSjgpiqQu3FERac8xNJqf0IY+NZ3jCQN97Z0sZMsrvAA2s+pXrp3OmzEW475NJq+VCDBtO9Z+69MWdBz9qxe2XRwul1J2041mz9J1n9I3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px57764e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C80C4CEC0;
	Thu, 29 Aug 2024 02:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724897710;
	bh=zVO/Ah/BvSf6XOZ+ooFRuP9AdsTAqFkEN+fM6Yvfmhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Px57764eBFvY1bfYsRQr1AUqUJaoYYzh/601uuwG0S+bjb8666VV0F7gyLXKZat+S
	 CVZd2AyjKTnsOPhFT9hEeZIxDR5UZH57wXNQ3V14vJy6Mhtpwu13ADrzvO2oE7cbkv
	 s3yqgnXKTKpyIx/Oj/fsXEdYKPKVeN0v9yCYkT6q3K2Yts3+uFk1SZ6Et7oPrLUnyr
	 r+1sVyypk6wFPIdW2lEFmFetjjn8O7GrHQEr8QO1AojvJH+FbTHWSkfiQDFhGW8zrQ
	 wKLNFQyTHYGJWAnBwCIPMaCUws/7IFo41HBl+dslTfVU6Ww3rHchpXxl3RLYcM/Tss
	 m6wp1QL3o6dDQ==
Date: Wed, 28 Aug 2024 19:15:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 0/3] ptp: ocp: fix serial port information export
Message-ID: <20240828191509.51fe680a@kernel.org>
In-Reply-To: <20240828181219.3965579-1-vadfed@meta.com>
References: <20240828181219.3965579-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 11:12:16 -0700 Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design [1].
> This series implements additional attributes to expose the information
> and removes symlinks for tty devices.

Doesn't apply now :(

Applying: ptp: ocp: convert serial ports to array
Applying: ptp: ocp: adjust sysfs entries to expose tty information
error: sha1 information is lacking or useless (drivers/ptp/ptp_ocp.c).
error: could not build fake ancestor
Patch failed at 0002 ptp: ocp: adjust sysfs entries to expose tty information
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

