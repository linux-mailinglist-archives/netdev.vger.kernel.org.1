Return-Path: <netdev+bounces-134156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22677998340
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E961F2343E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D961C2DBF;
	Thu, 10 Oct 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnmDxq/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EE1C2DA1;
	Thu, 10 Oct 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554987; cv=none; b=Vj03CEhdvglHt/PUWw5X0bF7cgqLrMt8KIZFdX/ppwoW6Tlr+mJy9mWMWeOZ66+XdDgAk1cpwXoxCEh55uTU4/ep8ffyuhCbIhIn9CBmJ0DNprQJ68mRfsVf78OdGWwTONVzci1eM/dhLMz6VHkSodd1f0a/SzAWmVJL0lun/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554987; c=relaxed/simple;
	bh=j6GAEoERZD7UeRkqfDNOjQFDSgVDtvchIHu+216zQcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnk2QswwDFE3a7xxyHXbIr7dU9nr6x6NlZ/OmL56GiwrbHtzbt+uDTbqibkUZwGzhC9YWJQM6vUXDIMd7w8fqVv+M7Dfcc3Yp844+3ve95Zk+6d3B8l+VQw7N+cPEff0OOes2fLNkH4v7l/4oifVPTs/BlfaVRGfuTZ9qaDL7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnmDxq/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90479C4CEC6;
	Thu, 10 Oct 2024 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554987;
	bh=j6GAEoERZD7UeRkqfDNOjQFDSgVDtvchIHu+216zQcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnmDxq/WqqN5tn+iXS09HUyaukKBBKzi9jnHr4p9Eevpl8dUoe4y8xwuZZZF9iHYM
	 FnbJ8Td3regJsB9lGsvAwHZboPfx0w4eEJaeTZ9bGYP+2OjZgkViL5ymqktHNmgmSe
	 Ep5AWqoVl2BFYvuJrkN+DJ7K/bc2I3HsED/NNKHDFuM2y8c2qgr+QR7qHevZ8E0cie
	 gRNX7pSzw40TxXks8lCppoMLSFR969B6W7dWOPZXQUMpd+6t6tc2hSLCCo4eB4Czq8
	 jKEM49SiVgaTVBWxQUSGWpcogrwoCAWNKIJ3qa6JHcq2pTJXgWVCo5Lx2hNwMiMJ/e
	 oUD/1Q8lyDNhw==
Date: Thu, 10 Oct 2024 11:09:42 +0100
From: Simon Horman <horms@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] eth: fbnic: Add hardware monitoring support
 via HWMON interface
Message-ID: <20241010100942.GF1098236@kernel.org>
References: <20241009192018.2683416-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009192018.2683416-1-sanman.p211993@gmail.com>

On Wed, Oct 09, 2024 at 12:20:18PM -0700, Sanman Pradhan wrote:
> From: Sanman Pradhan <sanmanpradhan@meta.com>
> 
> This patch adds support for hardware monitoring to the fbnic driver,
> allowing for temperature and voltage sensor data to be exposed to
> userspace via the HWMON interface. The driver registers a HWMON device
> and provides callbacks for reading sensor data, enabling system
> admins to monitor the health and operating conditions of fbnic.
> 
> Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

