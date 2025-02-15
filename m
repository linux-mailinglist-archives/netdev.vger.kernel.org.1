Return-Path: <netdev+bounces-166666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B4A36E91
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F63A03AE
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706031AAA1E;
	Sat, 15 Feb 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq6G2sTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430F1369B6;
	Sat, 15 Feb 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626898; cv=none; b=baRnZdlgfLm7XKVS56ek4beXkxeHiYFOFUq5vlrrUFBMTHMXUbEuGeWCSIPUT4iatvDybAPxdk6OnLINQ+48J54sT7f3iceRu5fjrgggveGqMueEDhjkYBkATw76+T9SaIAe057ZXQ03PcmKh7zXWYMiIT+hGqKperstwx2dqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626898; c=relaxed/simple;
	bh=yeTcu9vl4r9QphxsTeq7xKpWCz0ASDFy5OtMIzllk4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aENV2rzUsZ2uSnmvUweCXsiLEzLAbdEBBRQ0kfkTk0lb7qpj2AC/Lf4fc/80eUKpSHSVNaRb9s7hMYPc8vnm8BqQv0id8Z92i5SkNSK2o6K0MlpeppjJUOEnfYqLPWDLdVIg+tc2tFwlCrduZqwzlTvKq832L81Dg6CcbcRBbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq6G2sTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE70C4CEDF;
	Sat, 15 Feb 2025 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739626897;
	bh=yeTcu9vl4r9QphxsTeq7xKpWCz0ASDFy5OtMIzllk4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq6G2sTNFzbJpAVoTmTMtzrXTLdApV3i8pbkW7MtQ3bQ4Cxh/EWGMDberVqTttAup
	 WYGZCzJlIFuaP7+DHN/wEGz8pHH8uVpAocRh1GGNaSBkFt0asIOlESPxWg/pkdL5NK
	 IPXZWuca4Xl00e0sjvBxw2nYk4behlDzXUDEVoxYr8D7cQeXX/90E63rUV/HPoNn6c
	 +K171HJTuW0+baa6FSj88l1dPR9sgVQx2RkBE/G5Ouh8WISpMth9o3gB7qjm+o3+OJ
	 t2QOQXrTjw98wfvNh5J6a2zZQkMHBLGyjttLPKtsWSGrssyE6V3zLd4rtcGtWnt5A/
	 q6q2kaXtB9Muw==
Date: Sat, 15 Feb 2025 13:41:34 +0000
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net-next] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
Message-ID: <20250215134134.GM1615191@kernel.org>
References: <20250212185412.3922-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212185412.3922-1-pranav.tyagi03@gmail.com>

On Thu, Feb 13, 2025 at 12:24:12AM +0530, Pranav Tyagi wrote:
> This patch fixes a grammatical error in a test log message in
> reuseaddr_ports_exhausted.c for better clarity as a part of lfx
> application tasks
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

This patch was also posted as:

- [PATCH net-next] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
  https://lore.kernel.org/all/20250213152612.4434-1-pranav.tyagi03@gmail.com/

I will respond there.

