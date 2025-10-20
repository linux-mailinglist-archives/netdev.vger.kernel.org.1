Return-Path: <netdev+bounces-231025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B542BF401B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC548351B21
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5B2F83C9;
	Mon, 20 Oct 2025 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE2vs8EB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC402F7ADE;
	Mon, 20 Oct 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002422; cv=none; b=GlcjEef3jkgzHl8T4Y4gtigRCnLvFwM0/qXLlafzcS89AfeX718nl2g3GF7gbSBRpCSVIXte88ySIqq2oiIHafBiL7SqPZ3brGSNX9DPwrnEIoVmn4dHmxSBTEOD2iD8RbTl4r/JAY03Am3cn5kCy/V6W7CrWyk9wBNR8pUlBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002422; c=relaxed/simple;
	bh=pAY+pWhmYvX4Su/6QWwg4JfPTr2yPVSZqNGsjhW4igI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qrev1jRpWRr0U0uaaihFEdy6E7b403aUzSxVWhSsz2moHNq/vR2ja3wLdpXVRlJBe0ar/i1BBhjqYFk05Q92kgyjEd8QmsNxu7Nxcs+RzVXKXKPfH2mMcOsLlOUl6za2j/ylFVnG2vNCX6SsFHA1nIrdtG1Q9WhWJarEqLeQ0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE2vs8EB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D13DC4CEFB;
	Mon, 20 Oct 2025 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761002421;
	bh=pAY+pWhmYvX4Su/6QWwg4JfPTr2yPVSZqNGsjhW4igI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uE2vs8EB1bLL1fAZw7dEyoWZJ+33AsOsMZlyOoMJPsd/OnKsLhdPRQFmEyt5WhY07
	 PrKCk1TS1zz8rJeh1y27vaEjA/lDRvz10gtbnSoQLRXXm+vGGrsvHmxg/eReJDDZK2
	 Svr15p49+nscrIY2RHvTs3bD3z4a7V8tjf9FMM62Lzih3qQ7ha2cC+te8IftQn+lE3
	 R3rtGPNZxXqQRSy6nYazUcOnctPpQnO+loH0XjU5CP9nt/KRKm04hT+zHjosoQjdAz
	 LWj4JVNeb4BzqujNG3kbSPlPrGa32khElh+X4Eowyfmb3C3Ae63DkUMapEKYRDCK5m
	 ha1FItiDwR3WA==
Date: Mon, 20 Oct 2025 16:20:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 1/4] ynl: samples: add tc filter add example
Message-ID: <20251020162020.476b9a78@kernel.org>
In-Reply-To: <20251018151737.365485-2-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-2-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 17:17:34 +0200 Zahari Doychev wrote:
> Add a simple tool that demonstrates adding a flower filter with two
> VLAN push actions. This example can be invoked as:

Could you also do a dump and then delete? Make the sample work as a
quasi-selftest for YNL? Take a look at the rt-link sample for instance.

