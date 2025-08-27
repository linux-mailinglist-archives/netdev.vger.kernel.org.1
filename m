Return-Path: <netdev+bounces-217380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C87B3880D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D872980979
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009512BFC8F;
	Wed, 27 Aug 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOtxK+jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F029CB48
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313652; cv=none; b=rIdvg98IRlP4p3JY6yCHVcjKNL/QbPA0WEZQYoKWQ9EFqH0XVuYN8Dts25GVcIebMGh8ld51XGmmlcsfPy/bdJf2sDPLDiCmFgZfFPHgsP5rN/yoN4lx961xxLYOtjmenM9D4AgffX7jyDtuYYrwZsB2UOvmax+f0jvWCO5OuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313652; c=relaxed/simple;
	bh=ZZ6fZf5ItPv7PaAWeeF4ryTq0OnaypnW1i+rB1lzApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyIduFP+IhbTESwMmAoahgB9Tv3gQLkHEZ39j3vkBnE1U6C7Yb1A9u6SqtLn0JbwRhWhka/WC8F63q9xlPgJqF6JAlAngd6TVEwmH0LWZTTOjvGnFVWCymqjIzbbEKAhyoBeNWEQVjMVF1yQuNOAXuBbOTQHK5DEu6I3upxFG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOtxK+jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45AAC4CEEB;
	Wed, 27 Aug 2025 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313652;
	bh=ZZ6fZf5ItPv7PaAWeeF4ryTq0OnaypnW1i+rB1lzApo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOtxK+jx9BQT4q0af1aLkWn/UJJ+1zW6/CGQY4ycEfybf256lxjEzy5x5pJ/5sOs3
	 rM6fjvWrIGz3Gh4OICqk6fahjEqGQ1FbpLwKUjNBIGUeRsGniAL7JXkb7MJ41b5Hqx
	 JmkK76EhZA9IsoTmWrfUkCi9i3MKBcsCkG5z6pWIjUkjPWJA5/nmbXkqSzFJKbpORa
	 ILTsmyqjchHw9spODn7yKewvCJibsGkrG4DnjJHsXuXu6ZIY4UuVnlQ2B8cPFh+5EC
	 GKGH11Z+HxenbIp/JW5p3W6rljmvAlUEcQkQqCD4AFuM+/WA0yYdgiMBJz/I4f4lqa
	 ekPqlDAOManhw==
Date: Wed, 27 Aug 2025 17:54:09 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/13] macsec: replace custom checks on
 MACSEC_SA_ATTR_SALT with NLA_POLICY_EXACT_LEN
Message-ID: <20250827165409.GE10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <9699c5fd72322118b164cc8777fadabcce3b997c.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9699c5fd72322118b164cc8777fadabcce3b997c.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:21PM +0200, Sabrina Dubroca wrote:
> The existing checks already specify that MACSEC_SA_ATTR_SALT must have
> length MACSEC_SALT_LEN.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


