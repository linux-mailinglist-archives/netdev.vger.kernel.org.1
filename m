Return-Path: <netdev+bounces-41091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B727C99A3
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E59B20C0A
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41A7498;
	Sun, 15 Oct 2023 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r13FFCdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E982F53;
	Sun, 15 Oct 2023 15:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0577DC433C7;
	Sun, 15 Oct 2023 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697382008;
	bh=i1GxOtLnEEkuG6UtAHUPo6Syh/xF5t9Xh8yNbZzp1nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r13FFCdMoDsRZoAP3FchBMyje6QT4GpAgEDxnCM10TRk47MWPE0/XRFLgAAfv6FBB
	 CHBE1odsSJTtZ0QTDv0I2e7ycYgZ9Bqd973o5gXuRAdK9hlweTGTcVfAJO5IGP/v6G
	 5jU4mfqa5PWV6BGHMvlv/3bXwuV7l4KoFAIFy7WvZs8aknz/FK2yfb0ZSuZNl9VmJT
	 V8REeXj0mn0iybqhEYtCrQHkeVSyr5D4ysNdoRdgVJonfmaAjfGxr12sw8DF9/XqkN
	 YblNPv541aLT2Qg2VM0DExr++cI089lzsC6u+GMn7YrICTyV4u3eDWEvnWUn5i5e0m
	 u1e0iJxIVuFSg==
Date: Sun, 15 Oct 2023 17:00:03 +0200
From: Simon Horman <horms@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: smsc: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231015150003.GB1386676@kernel.org>
References: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>

On Thu, Oct 12, 2023 at 10:27:52PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("

I agree that this is functionally equivalent.

Reviewed-by: Simon Horman <horms@kernel.org>

