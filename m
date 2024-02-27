Return-Path: <netdev+bounces-75374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CE869A1D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5B62892FF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218C1419B4;
	Tue, 27 Feb 2024 15:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539F13B797
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047052; cv=none; b=gefQCMwzIw7f9j4z6/a+zWccB5WIR22drQVkXF/x8yQ3NNe+sO/AV9wpLj/9fKl5uu5IhucuWm5bCsaGQfHADJSPMKhgkAzGItvEdsRxiMcYYT/80Qbd1Lg6GWd7ax5eRqN1B1+DcS9F8gcxM7XMeqVLSKijLGnybIOACBlCe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047052; c=relaxed/simple;
	bh=DcG6efWL5vcxf/dpRxhf8tLC2swahuTz8eUGX3OlfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTSemEoNLYlLKNa6l29tJfaMIzn4FMzJfJ/6AVkJROepeY002tMv4ToB2+IQfdMekhfttHP4K2RJj45B30l1UDUVt8NoUI9l1sOnB5KBd1ZTEuao/PQrzSNXDTZBdpV2LQ5nMhcg2Fe4H6+rwl3g9Sk8W18IyMDZnpOaak+kAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rezCm-0005MG-Ag; Tue, 27 Feb 2024 16:17:16 +0100
Date: Tue, 27 Feb 2024 16:17:16 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 00/15] ipv6: lockless accesses to devconf
Message-ID: <20240227151716.GC12315@breakpoint.cc>
References: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:

For netfilter parts:

Acked-by: Florian Westphal <fw@strlen.de>

