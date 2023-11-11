Return-Path: <netdev+bounces-47187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AC7E8BA4
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6044C1C20327
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B08821;
	Sat, 11 Nov 2023 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qQqQG8yx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAB3C0C
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:36:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D1131
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4pdhHr0Y4+77gw/l6uad4GE1YEpryvdkIvWzVpgvO1E=; b=qQ
	qQG8yxUZzut42laMlUUt6bxRel++tmcrKdL9lIuTcsqEyFJEG2BM5RC32hTu/An7vBDRH44+j1LyQ
	21GxMW4OHtVKdmmXegCZ6Gh9ixBaKbgPY7TTcs75g2GQK4hzaySF7VGeO9XlNSfWJkC0sxgLlFOlv
	boxS4Fj9DCV935U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1qy2-001Mgx-2m; Sat, 11 Nov 2023 17:36:18 +0100
Date: Sat, 11 Nov 2023 17:36:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: mdio: fix typo in header
Message-ID: <623efc5d-802a-452b-adcd-c2fb11023827@lunn.ch>
References: <20231110120546.15540-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110120546.15540-1-kabel@kernel.org>

On Fri, Nov 10, 2023 at 01:05:46PM +0100, Marek Behún wrote:
> The quotes symbol in
>   "EEE "link partner ability 1
> should be at the end of the register name
>   "EEE link partner ability 1"
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

This should really have a Fixes: tag.

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

