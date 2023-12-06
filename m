Return-Path: <netdev+bounces-54254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680F8065EA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82251C210D7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFCDDC3;
	Wed,  6 Dec 2023 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1jCGUzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EAD52D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33BC433C8;
	Wed,  6 Dec 2023 03:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835175;
	bh=euYdC1YewejuARV6+qsa9p+6cQjqKmMrbRDcCpMKuGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1jCGUzt+Pu40VzNHpfiC0dFqL7eZgUs4bIZbpXypWyD39PFIS0NAddFX5RUzfp32
	 iVJ1hMFr2IkOWwwFQ3e8MJ1lRYRKCeqztbU3YNW+C8sJIjvh5wKqjMYwhqTA8mo8XY
	 xfqA4QSbmKaxv8Nk1kA+sNwZ+ScVmNQfMjSVrw2LB/Qb5q1evsEa8S1095h23wrNu1
	 RtuK5ktCBbPX0nV98fWjWJvbeAz5nIcYMvND/PaHDc312i03PbCj3gWiFCEWxGgsBD
	 YFBpc4Ictbta3iSRBHkuRCKEL6TCfa/s1jbkyY+l481TInfr7E9LJW4VAqwG7zBzMs
	 FDN1sxg+3m9gQ==
Date: Tue, 5 Dec 2023 19:59:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] dpaa2-switch: print an error when the vlan is
 already configured
Message-ID: <20231205195933.1b1fbf94@kernel.org>
In-Reply-To: <20231204163528.1797565-4-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
	<20231204163528.1797565-4-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 18:35:23 +0200 Ioana Ciornei wrote:
> Print a netdev error when we hit a case in which a specific VLAN is
> already configured on the port.

Would be nice to cover the "why" - I'm a bit curious what difference
upgrading from warn to err makes. Is it just for consistency with the
newly added case?

