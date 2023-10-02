Return-Path: <netdev+bounces-37533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4317B5D20
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4D1B2B2085C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3E1F16D;
	Mon,  2 Oct 2023 22:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5318208B2
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 22:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E63C433C7;
	Mon,  2 Oct 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696285822;
	bh=79cFsXTH0qYAJS5Y5EHSRryuk0cU8c3bNjf376YvJYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IzZEajQcdtcOlQdu0t+KOWccV9I8tJNmfAc0TXNtJ0FOSGdn1gwaVVo89k2r6hVHD
	 Im9qUf5syLC2SonUXONxJSOqGeJxVST1RK+jylYg31ZKd3BWzCdGMcpaazSphXpCEI
	 uqrdnU5LAbQsE8NwpR1Bf/V1Yxj0aHH9uWB2iJ0tpbNDu4B+nzYZgF+gusbfgXqdql
	 Gou0cP8aURCwJarjT07+UpBq6Nr5LomJoyG/U/nHvfD4prPTaOiyiIBGJKEyY26mio
	 OqHuP0bIQImFy4us2DonJeZW5o5GZGwPR6rCTDIby9S9RVA36aT10kKQT9JOLO0Bpx
	 ZHk/vOLb/NsXA==
Date: Mon, 2 Oct 2023 15:30:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
 avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <20231002153011.5444fd83@kernel.org>
In-Reply-To: <20231002143441.545-4-aladyshev22@gmail.com>
References: <20231002143441.545-1-aladyshev22@gmail.com>
	<20231002143441.545-4-aladyshev22@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 17:34:41 +0300 Konstantin Aladyshev wrote:
> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specificiation DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.

Still doesn't build, please make sure W=1 C=1 build is clean with both
GCC and Clang (you can point them at a specific path to avoid building
the entire kernel with the warnings enabled).
-- 
pw-bot: cr

