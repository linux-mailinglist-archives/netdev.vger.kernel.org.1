Return-Path: <netdev+bounces-106558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B9916CFE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9D42829C7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A96168C33;
	Tue, 25 Jun 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb4+N3l/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB549629;
	Tue, 25 Jun 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329206; cv=none; b=gv/O7BYn3TFe6+Ic7ZdzParsF8q3DukecgHhLFEKTzGTL4yzNMdrP4MF8F6tAAWNYMbfQI6zMNNqHxY13pm69EFlGAEcdou8UMVWfEZOBbQt/Y4uUM17oHeK9r5NKOFhHNLIsierEjY0eWXNiaujZcYW8K6kIEdrQ0ycLYrxCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329206; c=relaxed/simple;
	bh=i21U0kKDJmZcg+9RnGOSZEPcabKWNuu9gG+cDI+RMG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaee0OYAySr3VfGpiuzjMTeWdMuRjWpYxYrgts7bRpOYfgdWtJmbGXpfVplF7A7NxszCWV9H5XdOWgKQ+UBBKCGwxZruHja9ujPvcMamoK555JV0lIUKD8C+O4T3kIKOYEmP3MZK73wyAP7txBRJ/N9Ma9rNTtiOJpTfh4sb/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb4+N3l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F16C32781;
	Tue, 25 Jun 2024 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329205;
	bh=i21U0kKDJmZcg+9RnGOSZEPcabKWNuu9gG+cDI+RMG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eb4+N3l/QJ0r6w2kZA6JrQlLnsCesvhVsul01ikKYK4tZnXcbnJ6a+EcbSswuB3Hn
	 CQuGouLcLTiYtqCjFmz8RmIJu4Y+hrRptVk4ZipCfXndQGoFqGmhn2gXWNc6tb2rgP
	 xZ8dg7uA/MKWymW0st4Y8+HxMORsjIAhm40sX5JjWtLptpQdO4n4swCJgwbtesM38U
	 txB6K5Jw5o967OBiauv+wfAAO87/x8ysWALqRPi8XjFR7Dj0qsEhrd4XN/aylcozBK
	 tvo2MyN/U9n/V6w+FRxuuJuclRGlCOJEylAQTo90mOSHOjeEyDzg94l9YnTMDYAv/S
	 P4D+/apjpIZRw==
Date: Tue, 25 Jun 2024 08:26:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, imx@lists.linux.dev,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, madalin.bucur@nxp.com,
 pabeni@redhat.com, richardcochran@gmail.com, robh@kernel.org,
 sean.anderson@seco.com, yangbo.lu@nxp.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Change fsl-fman.yaml to fsl,fman.yaml
Message-ID: <20240625082644.52fdbdd9@kernel.org>
In-Reply-To: <20240624144655.801607-1-Frank.Li@nxp.com>
References: <20240624144655.801607-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 10:46:55 -0400 Frank Li wrote:
> fsl-fman.yaml is typo. "-" should be ",". Fix below warning.
> 
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/fsl-fman.yaml
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406211320.diuZ3XYk-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 807feae089c4d..7da4c469c14d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8874,7 +8874,7 @@ M:	Madalin Bucur <madalin.bucur@nxp.com>
>  R:	Sean Anderson <sean.anderson@seco.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/net/fsl-fman.yaml
> +F:	Documentation/devicetree/bindings/net/fsl,fman.yaml
>  F:	drivers/net/ethernet/freescale/fman
>  
>  FREESCALE QORIQ PTP CLOCK DRIVER

Already fixed by commit 568ebdaba6370, thanks!
-- 
pw-bot: nap

