Return-Path: <netdev+bounces-73261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D3185BA2A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650F628585E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E447664AD;
	Tue, 20 Feb 2024 11:18:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335A65BD9
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427910; cv=none; b=SKkSiKKnL2fvYQPn3CdgCIc3pdz0XhaqYPSaNAB50kIEXVczVhEC3vLbHkwWlq5t/eM1PzeEsTLPkwYGLg/8uDy9JvTv2SNE0b6Y2DQUmhl97CUy/t4WTe+vrlt53kme7Mul4WkaLDt22WfeNcEbjWOihgmjUhNxJj8qxSgZnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427910; c=relaxed/simple;
	bh=Zdioaw0O2hghNiOO2yDm8yMwg3IJjuY4bYwvuXyDl6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qraFw1NHrfEnGb/OHiDdeYEixYzMy2Ybl2+7KZD+OvTFnv50KGzxhRfGICIZATLgU3rHQDbHu8fqQlVZNtvCg2sVqXnJDYGzfhqz5AVsF/tDNyFe24XaIFVE7Mf7XOCVNvIwa3aMcjvZPg0O8OLrIyAmuzTC2GJZ6DpNtf1uqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rcO8m-0003ym-HT; Tue, 20 Feb 2024 12:18:24 +0100
Date: Tue, 20 Feb 2024 12:18:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: add overflow debug check to pull/push
 helpers
Message-ID: <20240220111824.GF22440@breakpoint.cc>
References: <20240216113700.23013-1-fw@strlen.de>
 <6b3e0b63889b4f3764bf7d2c2d761440d2ee02d9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3e0b63889b4f3764bf7d2c2d761440d2ee02d9.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> This is targeting 'net', but IMHO looks more like 'net-next' material.
> Any objections applying the patch there?

No.

