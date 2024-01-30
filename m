Return-Path: <netdev+bounces-67209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2084259C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DD21F259C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF36A33B;
	Tue, 30 Jan 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H03B4b8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9C67A10;
	Tue, 30 Jan 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619485; cv=none; b=s72G2wZVKP0KQtJTWidymhFrQNDKVf+QVwprPxPrM7wfDILKk9C+fXXpzRYokgTDkOlE69EOWNLvxn8BvZJvGebR6cxeplk9erjpSKuuQTnPDRVIDeHLL3Ztkh8zEccZX94e7OQ55Lal0QLCZr1JnOxsflwMvi/dA3zKntkGHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619485; c=relaxed/simple;
	bh=6yCoB9d+jtFqQMsfg9Udu4kBAW5UCuO7LSOfvL+fVLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8pOHQEBQw8SZpgQTDnrPtly+BWa6FWXZ+R2iT08oH6EmDS0WP77gBhgWLLuZ7Qac7cm/lg9QriRiBOsBaK/NHxOwvM9hhT1fSh1UQzsj2GgzIE3FTl6Nv4503d2DtoUz3Wm0Pu2HQKIy5+PopxnV5cj5DMG1BtK0n7vrv7lwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H03B4b8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A27C433C7;
	Tue, 30 Jan 2024 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619485;
	bh=6yCoB9d+jtFqQMsfg9Udu4kBAW5UCuO7LSOfvL+fVLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H03B4b8+t6fuKSf0kTmoiCY6gadtgw2ne3K9TuvQRJNH12xHtvYfRiHNevy04eFYM
	 kqjqiYNrsRHn77G90kh9/kmOWkzq1sMQZDHjuyB6vGJL+unkiS7xqBoNVMq8tzKe+K
	 vIxt3/7IVdFkfQZze41YIJM08QLG4NZzUJxj+mf2eeiTGSFUlWxlSH18hYN3eKNRaT
	 982zGNQ5bO608b+/+xcTf+HrhnxxGEZtk5M1D+QKHK63DGjaQDrwLa6YXN9WuFfkIK
	 i4kK9WmIogU6RQajsXDBJvPp4WVpuMK8i3pnW8SbHIgjXZs6u9H69UKH995pFhkVRO
	 gy4gDATIOh/Nw==
Date: Tue, 30 Jan 2024 12:57:57 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Michael Grzeschik <m.grzeschik@pengutronix.de>,
	dsahern@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 10/10] net: fill in MODULE_DESCRIPTION()s for arcnet
Message-ID: <20240130125757.GG351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-11-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-11-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:20AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to arcnet module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


