Return-Path: <netdev+bounces-281106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM2eDWeK7GmtZgAAu9opvQ
	(envelope-from <netdev+bounces-281106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:33:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92231465AF0
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B403017240
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6753386440;
	Sat, 25 Apr 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT8Q+d6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365B38551D;
	Sat, 25 Apr 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109604; cv=none; b=NHtzYnCHyZKSWZn4YKH8FhV7zRz6nq+7J/1WBGQdnOdxBkxrVmFmtZzZfFMdRP/VQi44o5Ezur+4qZfmCS8oJ6Sb5pUydUSpoRCnURw3Sm4tsOMHJmMVOKUuIlDrWGHN+EO8p3TfpgPE1RUHFf+czExIXL5Z/CVdj+0/pXcuFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109604; c=relaxed/simple;
	bh=vTnWUB3963217PH6E98v4MIyJ/E5FD6u2p/ki3Ycw2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwslgRnWNVx7vMC/1kbz6rJlnyI+caPp9NdhR+pc4hyo0a7vmDMMd2mxAaLh/K16H34GhY1NSk420aDKfY4ZhdO7E7S7TItHR1QEaTyMZXWg9D1rr4aSoBeGbfgjJniVtyOgaZqYhgHvRhBxDWe4LDpHRXA6w5LnVlVS9W9VGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT8Q+d6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AEDC2BCB0;
	Sat, 25 Apr 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777109604;
	bh=vTnWUB3963217PH6E98v4MIyJ/E5FD6u2p/ki3Ycw2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT8Q+d6o6nw+n1KPS+w1ZpJZl3Yc/tDH77v0iMYo8pnCj7XYzNRzqn66o/+5loj06
	 us0LWHBLCY0Uds+AjizRvxUzdDxpq3OEqzBhXN2rZVTAMXy+1f0/ElBO/GRYjTafII
	 ldWiYfqhzxYU/08LZsfArV9vUlP5cCPZcSqTpvY1DmjbiIjpyE5zlnOTAyKkpa/TEz
	 kYlnNDET7XxapKrMtaUi5ICdwN0WGH4T5M8XKc9kB6tRx9nDKJ6mbKKcGns/l2lZmQ
	 l8DJu3YF8zaf7wa6vfbTLogAeRe1ENAnhvwLfA+/6d+R4wvi/Nmd5X+oNQN7v3KF1Y
	 GNFTzaymKptEA==
Date: Sat, 25 Apr 2026 11:33:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com, horms@kernel.org
Subject: Re: [PATCH net-next v6 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260425-woodoo-righteous-earthworm-0ed34c@quoll>
References: <20260423085501.760-1-lizhi2@eswincomputing.com>
 <20260423085650.820-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423085650.820-1-lizhi2@eswincomputing.com>
X-Rspamd-Queue-Id: 92231465AF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281106-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	RCPT_COUNT_TWELVE(0.00)[29];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 04:56:50PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Enable the on-board Gigabit Ethernet controller on the
> HiFive Premier P550 development board.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 232 ++++++++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 103 ++++++++
>  3 files changed, 337 insertions(+)
> 

Please split the patches.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof


