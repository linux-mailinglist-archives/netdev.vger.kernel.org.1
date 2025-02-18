Return-Path: <netdev+bounces-167491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7CCA3A7ED
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD19C3A4B5C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D661E521F;
	Tue, 18 Feb 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOUNg1mS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493621B9C7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907858; cv=none; b=GKo4q4x0lyc4v40CPbaF1mGFCF9dO+e1pnPvcdD850/T2E75riJ6GoMchT9nEWgnFPJSYaEXJp9MbOeFyifxrFDOYuL+bSXFLAYfSgDVmenHbtR3t8RVXwur1Vohw4XyZC+hkkazgFyhu5eyZ+Sir4V//WmQzg33Z4qSK6QXL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907858; c=relaxed/simple;
	bh=yfBdMa35IlSvleFq6g2qm9/i3iJnx+wl9Zmp0L3NA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJaKbfQdNT0RUEr1FkJUn2RZMrilSF2xP0kYb31cwBrTNdrrAZfdxuc3vO3P7EQ/8h41m96OUc3dg92xzdzm4h8vozjgou0bDTD5g/Vsk6eKnxUgp1hdqOhZbhZ1NkljCDe8osuxocBdvqVsWgRLp9cZW8bHMboqr+CenTgCAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOUNg1mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC9C4CEE2;
	Tue, 18 Feb 2025 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907858;
	bh=yfBdMa35IlSvleFq6g2qm9/i3iJnx+wl9Zmp0L3NA0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOUNg1mS2+ePoB/va/94jEyM8uXG3oGoylobTT9qrOxbh8bosEj5q27D143uxrVL/
	 0hYpZC27IGVKDhBr71U/EMLKfpbzDNrmndz5VHmc8qq1+8v0+CTSMGSz491C3EqcsF
	 Z7SoyIqlQ53pb4uSjDiVt6hGwGm6gy8EzX84s3bNdy8w1SEm4xbS2u00Dz8iJqvsHz
	 9auyipr035MthzSfjDr8izQfB3SNVb9knXPRtdomluOSWFUm/PfqePZ9r2Y+wVDGFk
	 YEDEeCB6iLVoaShdGsMMRnghfoLrwBL0NYXAfjaB68q7s5qNagFBPv2XSSXd5sMyjj
	 R4ZAUKNNSPy/w==
Date: Tue, 18 Feb 2025 19:44:15 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [iwl-net 0/4] ice: improve validation of virtchnl parameters
Message-ID: <20250218194415.GL1615191@kernel.org>
References: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>

On Mon, Feb 17, 2025 at 11:27:41AM +0100, Martyna Szapar-Mudlaw wrote:
> This patch series introduces improvements to the `ice` driver and `virtchnl`
> interface by adding stricter validation checks and preventing potential
> out-of-bounds scenarios.

Hi Martyna,

The above talks about this patchset in terms of improvements rather than
bug fixes (that manifest). If so, I think this should be targeted at
iwl-next (i.e. net-next) rather than iwl-net (net). And the Fixes tags
should be dropped.

...

