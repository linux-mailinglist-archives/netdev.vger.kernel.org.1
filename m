Return-Path: <netdev+bounces-242468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB96C908B9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BB63AADDF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBA1E8342;
	Fri, 28 Nov 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOTwRGyG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132F1C861A;
	Fri, 28 Nov 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295129; cv=none; b=IbeCIPG0mazxmziFzHpRjyxuUW7xPUfJ8CDo0MVCZoBSiVmH0xL3+BwkQzy+vEqSemskJSsJ+HFqI6rplsPFFX8+ev+Ci4B0ay+NgcyiVVkaqiPWIT8WVFPAykjnWnAMSrmGDIwuC+ZVvvuAygtKTxhi1k+unPi1/7eCooejBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295129; c=relaxed/simple;
	bh=2MjLmqxKrSGxN8OTCCPOkPEDfO/fHISTuhyX8eizPaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPX2ATEiR7XRIXyxn3tCwCQhWCjkMEY6S6S9V3bMzQQK3vNBZ4CBikTYpltndqdsDp1C1vcy3o1yN2DX7wPFNRtHWWJrMSDOSit52I41oTWe5jVaK2w3kfngZkyXPXIbkBFV3GO6gPyNhHiHe8uhZ+IysIGOAqNsOOz0gdi9Q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOTwRGyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6CCC4CEF8;
	Fri, 28 Nov 2025 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764295127;
	bh=2MjLmqxKrSGxN8OTCCPOkPEDfO/fHISTuhyX8eizPaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tOTwRGyGOVo8BOF9z2qPnYS6l6JikPqLp+uQDMdUZClHcmCRnXUo/rv8wnmVsCqVi
	 ITF0CEnYhfcyhcCzolvqshPiQOCra7ko7Kv49HKTYI37Q6JI5uUdEw3dvVSs7CgnoF
	 TM5b2aVtcIhlXrp6H/+FBcc7Rcr6Daa0Xx6gDTGUAzp9dh+4zm3gMtLqpAmPynlRnm
	 s7n0mZ0QlgXB1d6pfqDh7MR82naD0XQZ8sAgArFylYxXGwzwWm28YiX2iYJpRqaG3v
	 ijHT1Ha7UkJAxrW+Ag3EEWWNrj/ozO2nrOq6XnGIy21OQZzdM2LjOCjxFs1pmjtLZq
	 jiB+DMD5/l+aQ==
Date: Thu, 27 Nov 2025 17:58:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: dsa: yt921x: Use *_ULL bitfield
 macros for VLAN_CTRL
Message-ID: <20251127175845.3db1b0fb@kernel.org>
In-Reply-To: <20251126093240.2853294-2-mmyangfl@gmail.com>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
	<20251126093240.2853294-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 17:32:34 +0800 David Yang wrote:
> VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
> macros use unsigned long as the underlying type, which will result in a
> build error on architectures where sizeof(long) == 32.

nit: sizeof(long) == 4 ?

