Return-Path: <netdev+bounces-20567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080DB76021C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E232813E4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E611CB6;
	Mon, 24 Jul 2023 22:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9472125A2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A3AC433C8;
	Mon, 24 Jul 2023 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690237187;
	bh=425+WBK2OHG+zwFkDdiZllRXGkahyPld5eZHxp0qNCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB5Vh8CnjtlFrL5H8aCRT9GdOvAfhQSp42PknMP8fnQ3qBkOgD7rghSbbatMeImrj
	 7dQ7QB9KQcLWdGYtUpRGlgXEIe1jiBJ4FQRtMR+WgNY1MISEVjW5nOApaKpkco6ODq
	 Cz6BLOgFomN2WMjFzrS48oyrkTEWiVDdmiRON7xHsu93DfIWM8UVsqnXPX35gf2p8i
	 UhxtMzdwrldWaGuN15Vkn2yt31IxnpqjhldWmQ1h20I3zU4Sqewc1krtN8CE69bJR1
	 P9fFAzOGGGnsa6yp7M9dh/PcA1YEPa4xziW2yaJugJ0FnrZU8lh+gzn84gvcry4ATR
	 2Ig22a8fkI0Ug==
Date: Mon, 24 Jul 2023 15:19:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, simon.horman@corigine.com
Subject: Re: [PATCH net-next v4 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Message-ID: <20230724151946.04deb72f@kernel.org>
In-Reply-To: <20230724102521.259545-3-arkadiusz.kubalewski@intel.com>
References: <20230724102521.259545-1-arkadiusz.kubalewski@intel.com>
	<20230724102521.259545-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 12:25:21 +0200 Arkadiusz Kubalewski wrote:
> @@ -438,7 +438,7 @@ class YnlFamily(SpecFamily):
>              decoded = attr.as_struct(members)
>              for m in members:
>                  if m.enum:
> -                    self._decode_enum(decoded, m)
> +                     decoded[m.name] = self._decode_enum(decoded[m.name], m)

The indentation looks messed up here, otherwise LGTM.
-- 
pw-bot: cr

