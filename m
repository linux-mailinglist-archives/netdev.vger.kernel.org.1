Return-Path: <netdev+bounces-205116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F08AFD6E5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FB58491A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306262DAFA3;
	Tue,  8 Jul 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeS4lP9c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07A8488
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001727; cv=none; b=pm/D+fbs4T2qLinFNyeQzzzOvxiBiFxQNv1bh99IqAWFg33VSWfVw4b/Eu2SX8NuTX4rhYY7Eue5wKjqrAof7PNAWTZmKkKm2BhzqPkMHJWvnMERMOIaGoWD30tMkMaIm3L4SgUszSqVvVRB/fpdHrLU13xiZr2VcY3GUaX40bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001727; c=relaxed/simple;
	bh=q6CRtS8N2jyKEbwDb4Fjb/cZp5rYJB1kA0xyZFb8voc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f52brnwJvj7MnGZe9qZrCRHWyKHiQI5nbbm1zvW+h1FH3zgtNj92Nrk8EXrNEfsiNtLhGq9nGceVmxiEbsCZ9yf/5LAA7AAENQJk3bJmIxD9VnWt9y05Yl/QVAh/jed3BbWTBPlglo6/DlRlP/ZsX6MSRFUyZ1NbRLK71F7jBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeS4lP9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982EFC4CEED;
	Tue,  8 Jul 2025 19:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001726;
	bh=q6CRtS8N2jyKEbwDb4Fjb/cZp5rYJB1kA0xyZFb8voc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XeS4lP9cMQRwtAGNcudhXJxAteehlOHyGEf62tsYXcSqS6g33+z8HdOyU9vwaDdnm
	 WJHUocCMQ+RbpSMwjSJo+/2NM7Hc9XgsXRuvrUS0M/1l5YHQgVhfjHqFuudRLLiZu9
	 mrvdlJ8CsqKyrVTcZX8wNyC+gS+Q/bNQhGTGdXhigQbaE5a4haSanZJU81IEg1VotR
	 zJy9DNXVzj5cwg8aSnfcGCMeRirspQlYVlExM11Wda/94UYNhMWRIBvpznedYftxo4
	 Mlv4yljfHhU0LH89UNksYbihnN4yZ7eUrob+49w0YSyOhe9TYnaqnRa//H0mUXRi3W
	 zD37hig7Y2I9A==
Date: Tue, 8 Jul 2025 20:08:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary constant casts
 to u16
Message-ID: <20250708190842.GA452973@horms.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>

On Tue, Jul 08, 2025 at 10:18:35AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


