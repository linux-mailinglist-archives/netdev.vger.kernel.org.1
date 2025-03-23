Return-Path: <netdev+bounces-176967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F939A6D033
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FAF3B4456
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49D286325;
	Sun, 23 Mar 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1WrElFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135F78F4E
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742750325; cv=none; b=gUfZ+WoP78OS/pPk7wyxIgpHNB592tWsLbjVHkHmNPrT3+YdWh3wFol87684SnfGa2uaFOvISYIPYDFyrg5tHaKmhB/GCZCIloHs623byRwpuh6K1gAWkiylBFIODFEHENx0mPfaToYy26EY8AXGuavlFcMjYOwbqyLddwzMZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742750325; c=relaxed/simple;
	bh=ACd3aNCJKDjrsD6vE+9ydrly4YE7OktTx4AyC6/em0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr64sJGJ84w3J6EzY/TMU1J1/hsiu55GjDHBAFCb+t+UHFRRmUBapQXJ/GULsxM056DpKvLdUIIDqWbcTQb2iLvwgStzHVBgMceszewBoYa4gSUmhIbk+xMkmJUwqujn0dqdSiQKB+uCLT5HvwaWpUIBC1tuV7AWpwWkvTkjn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1WrElFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD7C4CEE2;
	Sun, 23 Mar 2025 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742750325;
	bh=ACd3aNCJKDjrsD6vE+9ydrly4YE7OktTx4AyC6/em0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1WrElFUd6olm6BYOh98tHy18qswX5UBXZSYNqC7F4qax234NQhDO28XiLyHHzb2Z
	 IU6tRUgQqbkwGKPgnLLCZpHlVwLLYcFBTKsBHLP99Q6vJCm3QJpYAcJuzAXvMu9psS
	 CWbFh4X9Ga8E0taEb0TcnfAS5VUxdvE153sQm2QbkLmcJFeD+TLUqHwXsa0GqnZYLl
	 ClPL76IgHjm7KEv/J1FEa3jZ98wnzf3y+uecQlbeCRG/pk/vsdQqYh9EF5ulbqUk3V
	 3S8EemxvXlMFHQsgyuAweKlIFlUH7QUEz3SQ0k9nv/Cv2D/V4NQep5AJYT77u4sIhQ
	 uLbTXitJepgOA==
Date: Sun, 23 Mar 2025 17:18:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 2/4] net/mlx5: Expose serial numbers in devlink
 info
Message-ID: <20250323171839.GV892515@horms.kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153627.95030-3-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 04:36:25PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink info allows to expose serial number and board serial number
> Get the values from PCI VPD and expose it.
> 
> $ devlink dev info
> pci/0000:08:00.0:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0000:08:00.1:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


