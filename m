Return-Path: <netdev+bounces-133196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FB99547E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1131B2169D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9861E0DB5;
	Tue,  8 Oct 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8kqBqXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C191DF745;
	Tue,  8 Oct 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405321; cv=none; b=MhpJC+ISVfwljCuXL+b8TY4apBwKlwaTvYn2RXtfWUMglAr8dqVaGgVE9BGEd1SgMNwQvnIghhx847eEvappnru816h5VWgGD+RBxq0b65Qg6lZv3BzIVbPq5FeVd/zJwvSN/0qoRUurKoFID1hwXzYtlqHhchKsmUBdI2yTdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405321; c=relaxed/simple;
	bh=d17yIPVx8tvq68r+q/1NE1q12eUk96uCe++BFPLzUM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv9K4g18QAjkTurvNsdCwr+dly5p7fEletTYek41cMAJuogG4mo7ESRMCxa4rpnuVW++51SbWKttTfuexht8LdcADdW45uT5Z6ctxvBazwD63zDLCCRepILyO69H3eXe2xsHmPFWWqEbRGnGtyW3fQTeUtc5BYyTh/uAyJlNs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8kqBqXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2836BC4CEC7;
	Tue,  8 Oct 2024 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728405320;
	bh=d17yIPVx8tvq68r+q/1NE1q12eUk96uCe++BFPLzUM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8kqBqXoqKpCHP94b46rBRry/USElkcI8Fm11nx/R6eQL5kem4JaiVg45QD041Him
	 ebcIMOQDHWDLbnH5N0zlvBcyr5ywtaVuXb5VEhUC7viZUjO+gf3wX8s+yx/OtXWTVn
	 IT/HvB9UMfzEbCFY5eeug3VkZGJpuYOARN9UpKp/GIWSgSZtSgKcYsbndT9toQ/aME
	 tvnw/57/vwLet3hWP7X6m2k12o+w7OAjGO+NHgENbdVtWv6DF4ccK8PI0Zn4Sidttd
	 9BDIkdkh9vCc8vtETpjsgRuUd0sLCy5L3slfa4WzGKakR0RXvqexIKBhntvBCBRN8V
	 Byd1xcTQGcxEg==
Date: Tue, 8 Oct 2024 17:35:17 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] caif: Remove unused cfsrvl_getphyid
Message-ID: <20241008163517.GB99782@kernel.org>
References: <20241007004456.149899-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007004456.149899-1-linux@treblig.org>

On Mon, Oct 07, 2024 at 01:44:56AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cfsrvl_getphyid() has been unused since 2011's commit
> f36214408470 ("caif: Use RCU and lists in cfcnfg.c for managing caif link layers")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


