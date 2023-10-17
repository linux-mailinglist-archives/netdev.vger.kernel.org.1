Return-Path: <netdev+bounces-41683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B77CBAB9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B55B20D88
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C6D290;
	Tue, 17 Oct 2023 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7984C153
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:15:13 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3EB0;
	Mon, 16 Oct 2023 23:15:11 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1qsdMA-003P2Q-Dk; Tue, 17 Oct 2023 08:15:06 +0200
Received: from laforge by nataraja with local (Exim 4.97-RC2)
	(envelope-from <laforge@gnumonks.org>)
	id 1qsdIe-000000020Oa-1ZtF;
	Tue, 17 Oct 2023 08:11:28 +0200
Date: Tue, 17 Oct 2023 08:11:28 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Takeru Hayasaka <hayatake396@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <ZS4lkKv3xfnkEWRi@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016152343.1fc7c7be@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub and others,

On Mon, Oct 16, 2023 at 03:23:43PM -0700, Jakub Kicinski wrote:
> Adding Willem, Pablo, and Harald to CC (please CC them on future
> versions).

thanks for that Cc, it's much appreciated!

> My understanding of GTP is limited to what I just read on Wikipedia.

If there are any specific questions, I'm very happy to respond to them.

> IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> which the protocol runs? 

that is a convention.  Similar to any other wll-known port

> Are the frames also different?

Yes, the message type is different. There is one specific message type used for GTP-U
and lots of others for GTP-C.

> I'm guessing UL/DL are uplink/downlink but what's EH?

Surprisingly, I also am not familiar with "EH" in the context of GTP.  It's an ancronym
I don't recall reading in any related 3GPP spec.

> Key question is - are there reasonable use cases that you can think of
> for enabling GTP hashing for each one of those bits individually or can
> we combine some of them?

I cannot really comment on that, as I haven't yet been thinking about how RSS
might potentially be used in GTPU use cases.  I would also appreciate
some enlightenment on that.  What kind of network element/function are we talking
about (my guess is an UPF).  How does its architecture look like to spread GTPU flows
across CPUs using RSS?

This is by the way something that I've been also seeing with patches
against the kernel gtp in recent years: People submit patches but are
not explaining the use cases, so it's hard to judge how relevant this
really is to most users.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

