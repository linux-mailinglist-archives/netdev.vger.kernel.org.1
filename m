Return-Path: <netdev+bounces-184358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83CA94F9C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192921893D5E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FB261389;
	Mon, 21 Apr 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTIExyqB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3021422B;
	Mon, 21 Apr 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232887; cv=none; b=b5ZtlesONcQuA24SlVdBh8/CKV4HyIA7x9X1f4W0bxYOt5hql77AEzC2V2kZ7Zxnv+vkBoDQgHwBqLJXzSliakzsXsxet+PLTAN+fl5YcKzXLIzItpEdxNLEE7nieorL1mvhYOTnN8chVYveypxLr/NJ4cXcfavw5563bhiVauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232887; c=relaxed/simple;
	bh=LEuhg3QEiZ6kyfe7rKAsW7JOjJ+ALxlRlRNg/duLxIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhmt2Bk3b03UaOGul+gFfCp2khEEhAVG37h6I1XAOA0uio5YmVoN0Li3p4NRk0jivUWL+ZyyyfMp3yuMaqBMR2KXssg013IDm+Mbr/WE/sYZqLdafllLLMEKvJ7XAEt6D7hfGwd2qcCTrHwRTCIWSa2FbbYVpSEDE7AuVdxOZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTIExyqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC57C4CEE4;
	Mon, 21 Apr 2025 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745232886;
	bh=LEuhg3QEiZ6kyfe7rKAsW7JOjJ+ALxlRlRNg/duLxIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTIExyqBIH1FbNvpAtGQOAeqlm6xL2AnnCtC1aBA9OyDolchhLXuu6VCuyScsW53/
	 CbfjP/9+7Uz5rTxz/W5cu4dZTWRJS1gZeR12rb12JKss97/QbNL19Hfw2kxK8t/cZR
	 IrftUa+XR3+d3Nz+wNsbnqrBYKU4wVg9SA497fwaphLSgHcjAlcb7Q50jsPSILW3gR
	 Clo8UjkSVKOymcAHD9BK9ebMLJ5zx8iAtE4H2FXJVwt1sHj+m3JFPNoJ/6Vz8+i+VT
	 Ifs8EJnsYBFMsqdIdyBLp0J2qQ4o4D5S1n1ZHwPQm2LBzEbKUhjp/bDbFg8GfXsTIc
	 vmyHk1LaTm7wg==
Date: Mon, 21 Apr 2025 11:54:42 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH v2 net-next 3/3] ionic: add module eeprom channel data to
 ionic_if and ethtool
Message-ID: <20250421105442.GC2789685@horms.kernel.org>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
 <20250415231317.40616-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231317.40616-4-shannon.nelson@amd.com>

On Tue, Apr 15, 2025 at 04:13:16PM -0700, Shannon Nelson wrote:
> Make the CMIS module type's page 17 channel data available for
> ethtool to request.  As done previously, carve space for this
> data from the port_info reserved space.
> 
> In the future, if additional pages are needed, a new firmware
> AdminQ command will be added for accessing random pages.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


