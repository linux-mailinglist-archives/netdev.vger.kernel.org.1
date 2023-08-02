Return-Path: <netdev+bounces-23514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81A76C480
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659B61C211C0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F668EC5;
	Wed,  2 Aug 2023 05:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046AEBF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E6C433C8;
	Wed,  2 Aug 2023 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690952624;
	bh=Lh/8DXYnrVwSuT95CJrJrjg3AAwX2dmsR+R7uiAEAko=;
	h=Date:From:To:Cc:Subject:From;
	b=r8e2tnRr6NR/LJPVYeu/KXYVkqyD0lFLFN6wGOkUXSTnUvkHDwxIOHNPqVuq3fu18
	 dW+IjDhbZTUUy5VqJL3lObzr1M3wg9vwgla000FujrcSx8KH3fxIaGKnFHXW8HruSy
	 aoeKf9L4La43QQvz+pDwhEZOykqvRb2M6cNfJOMAfR50hmRGcM19Wtos27b39mV66G
	 G6E3LxGY1Sp5kwbXVMy+Y+h2BFcyVip+M00JjLHhuP6t9Xb4B90mubprHGO93YA9yX
	 GGLeuFgMQoA9czqR3P1/u6sJZX5FR1OPeiUhgC8R0atIvazIzrSgdU5TvvZ6ZyLDcN
	 Vc6wXOtl+e9Mw==
Date: Tue, 1 Aug 2023 23:04:48 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	fam1-i40e/0001-i40e-Replace-one-element-array-with-flex-array-membe.patch@work.smtp.subspace.kernel.org,
	fam1-i40e/0002-i40e-Replace-one-element-array-with-flex-array-membe.patch@work.smtp.subspace.kernel.org,
	fam1-i40e/0003-i40e-Replace-one-element-array-with-flex-array-membe.patch@work.smtp.subspace.kernel.org,
	fam1-i40e/0004-i40e-Replace-one-element-array-with-flex-array-membe.patch@work.smtp.subspace.kernel.org
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/4][next] i40e: Replace one-element arrays with
 flexible-array members
Message-ID: <cover.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace one-element arrays with flexible-array members in multiple
structures.

This results in no differences in binary output.

Gustavo A. R. Silva (4):
  i40e: Replace one-element array with flex-array member in struct
    i40e_package_header
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_segment
  i40e: Replace one-element array with flex-array member in struct
    i40e_section_table
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_aq_section

 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


