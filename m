Return-Path: <netdev+bounces-18810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA2758B78
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2233281869
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89718E;
	Wed, 19 Jul 2023 02:44:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D117C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF1AC433C8;
	Wed, 19 Jul 2023 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689734673;
	bh=i6ODCpZdw7yLI/3Tk1F1jRRURwyjESiWyE6EJzeWL4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GyXCHH1o6MXRYbpwlAWo4bDRRNaRqreFxfEWh0bv1gqA+vFzisAQkWBWtkkR2rolW
	 S+i0qIHgWdTNZOoRGNoPF+EkIPIeORj7roVfF68SIRnaPCRBM9ijv6lefLhqZRByyC
	 Xg8WIpkO+pv0vXIEaolUwgguTnnrLcBu9+M0oqRMf6AN3TjxSY7OcUDV/bUSUPnnq6
	 QwAX0DgHnxeHhs8/50NznKzCII/5A6/lY3ly853LXskuA2qmcOj22UfMuGtcKXNzLr
	 m8b96MtnZlVYnKNLUyLsHeAkHgpWGeDSopECi2I75Fgeky1JzsvHjJinJfTYCXRffs
	 TmUnKrM3uaIqg==
Date: Tue, 18 Jul 2023 19:44:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
 <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
 <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <maxtram95@gmail.com>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [net-next Patch v3 4/4] docs: octeontx2: extend documentation
 for Round Robin scheduling
Message-ID: <20230718194431.38c02846@kernel.org>
In-Reply-To: <20230717093319.26618-5-hkelam@marvell.com>
References: <20230717093319.26618-1-hkelam@marvell.com>
	<20230717093319.26618-5-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 15:03:19 +0530 Hariprasad Kelam wrote:
> +4. Create tc classes with same priorities and different quantum::
> +
> +        # tc class add dev <interface> parent 1: classid 1:1 htb rate 10Gbit prio 2 quantum 409600
> +
> +        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
> +
> +        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 32768

last two rules should presumably have different classids?
-- 
pw-bot: cr

