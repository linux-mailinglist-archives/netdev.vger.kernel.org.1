Return-Path: <netdev+bounces-249213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADED1593E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07275301D637
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A12BE056;
	Mon, 12 Jan 2026 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4cmYAUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F92853F7;
	Mon, 12 Jan 2026 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257011; cv=none; b=ihm5XISNzaHsQTxyImIT8PMMdpTjQA6uw4jOh9zi9Fog04uIhiT1hIpZHRLyxIcm/crSgfrJ6UAMbTYwnuSGBlYOAuEsqID9C1j4u97tZ4OlybMlWB9eN643lSX0GniRyuq57VmSpApYeRhfO1oayExWiSnYp9T1xpk3h0KDuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257011; c=relaxed/simple;
	bh=8IUNU2izqYPx8xVcqrgupLEBCOzJLxpf7RDx4Vg+qCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4sVwgmApY/QYS9hoPpzi8Zf9KRik7YK7PgFHjCVeyKqruaFf6hDWNLNsSplgWsXxe1sR4f4RfeEY/brxxM6EjqHMnPqoBXunmPnfC2AjE2oVR7sUFxD36SW4tdEw7WCE39BwpLw+5WzmuVBuz/lXprnauWjRhFCR1VzBzbKwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4cmYAUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A816C19421;
	Mon, 12 Jan 2026 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257011;
	bh=8IUNU2izqYPx8xVcqrgupLEBCOzJLxpf7RDx4Vg+qCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4cmYAURIS0qgCDVcjEjCpefLJ0Rnfgq2YFeL2D7cUoOhoD1nUWfkI3ifBkkfuCRg
	 p9lOJcd/MIdxidVCUDGOnYjIPRnzjAxnzJXgsWisXpNC7RMtyC7bmmvSD5RjmZyiui
	 VV6gZ0d9hHzwDFgSb32mmZPN81PfAPQMv/HnxDVdNs4JR1MTLxGYUeSiUEBku6PtiR
	 daKGnfFYWdUIU9k+B4pllaBgKjAs7dl9F29ajmUjZyyx2KGTYvWNWO5sKrCOMDi+Wq
	 uWTApQlEvp54/1xcKgoZqYR+FCckl6HKzncFLpwiesvTfCVBSjQ6fKRmXdubNrf2L6
	 Lyyk1XT6O5Riw==
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] crypto: af_alg - Annotate struct af_alg_iv with __counted_by
Date: Mon, 12 Jan 2026 14:30:09 -0800
Message-Id: <176825700791.1928769.12947849877684705952.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105122402.2685-2-thorsten.blum@linux.dev>
References: <20260105122402.2685-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Jan 2026 13:24:03 +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'iv' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] crypto: af_alg - Annotate struct af_alg_iv with __counted_by
      https://git.kernel.org/kees/c/98569017111e

Take care,

-- 
Kees Cook


