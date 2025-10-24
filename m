Return-Path: <netdev+bounces-232595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09501C06DFA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EE41C001F5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE5322537;
	Fri, 24 Oct 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puvMqZex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2D35B123
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318601; cv=none; b=k/s9UbANAWRo3IJs7ArRBZMXJG+Vcb63tnDfyRcT212y7bUu+e2H0V/zNMitS8L456E5CX0R91X+Pw+JVEbIaTiY1qsEVogfB0wpIHkNaKt3Tq92LaC0zragBEOjg74kWViBjE/cI7Axz3ph79PvfclCEX9vgVJ4ZxvyC5z0ABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318601; c=relaxed/simple;
	bh=/ayEl5bycYiQTuP07MQp4jDgikh6qCgTzXjFnxQ4TH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/vj50DVr9xZCoLXwmahQF3ABfxo1d32MQYZKOwQQkOm44BR1ybt6UFQNEjB0IVW7+mp4oueJS6QBx5DfbZpPXHgX8j/gXXvPtmAJ1G0k7vsDoPxoDxgtnY3GOFEeKMylTCKqqkODgpnU8z/7fgXt59EYW6qrqpJGH21fS3No8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puvMqZex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA34BC4CEF1;
	Fri, 24 Oct 2025 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761318600;
	bh=/ayEl5bycYiQTuP07MQp4jDgikh6qCgTzXjFnxQ4TH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=puvMqZexna7QMswU+RwAO0dICncCxPjgsVAdEqG1MV7RT3hcc3U5xb4Q+QXUISOXb
	 3Yjm/b1DFthDPcoBnQSniExUjNdx3gidMVWjM0OYjkERneQtBh8DHyV/AHNUIpJCAn
	 90jTMQYhLuaHo8LT7UTGQdN4274mn+xPDaJbXY3oYasjTfG0sGDaMW9lu0UglM2P6j
	 l+0umnA+7/yI83HlVv327EydMuF3t+6WxCtk4kEdd1XWXIg//cvqqqAGG0aTMBo09E
	 TDoRZr0lXIyjxgB3ylGv9YCcyjrvOEdPgJAKpAuRzgwVYZJgXXQhyPWKuE/T9ZrvNU
	 zJXN35cO9qH/A==
Date: Fri, 24 Oct 2025 08:09:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: ynl newbie question
Message-ID: <20251024080959.55e7679d@kernel.org>
In-Reply-To: <MN0PR18MB5847A875201DF2889543A61DD3F1A@MN0PR18MB5847.namprd18.prod.outlook.com>
References: <MN0PR18MB5847A875201DF2889543A61DD3F1A@MN0PR18MB5847.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 13:39:57 +0000 Ratheesh Kannoth wrote:
> HI List,
> 
> Followed.
> https://docs.kernel.org/userspace-api/netlink/intro-specs.html
> 
> But I get following error.
> 
> root@rkannoth-OptiPlex-7090:~/linux# ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml       --do rings-get       --json '{"header":{"dev-index": 18}}'
>   File "./tools/net/ynl/pyynl/cli.py", line 19
>     schema_dir = os.path.abspath(f"{script_dir}/{relative_schema_dir}")
>                                                                      ^
> 
> Should I install anything ? there is no "/usr/share/ynl" directory
> (code cloned  from  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)

I think you trimmed the stack trace a little too much?

But my guess if you're having issues with the schema is Python support
for jsonschema.

BTW if you're using Fedora ynl is part of kernel-tools.
Not sure if it propagated to RHEL/CentOS yet.

