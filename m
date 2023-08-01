Return-Path: <netdev+bounces-23196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA376B4B2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578A228194C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD521508;
	Tue,  1 Aug 2023 12:26:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1A1F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E09C433C8;
	Tue,  1 Aug 2023 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690892778;
	bh=z/nyCG9+MiNrNRu+oLH9pPDpearklCL8X59wA3OOsig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvLJYuFJyi9SsFp6dSCCzCzzm8WudEuZYex8cFrrT+MrsngbA/QSrMpZbr1D695v/
	 r5dapol6Bij4T7cZB4M1ALVbhlPAFGyiuNpfLyW/qwO7Tq03g518FWHBCpdtMKZFnK
	 X7XLjJ/6yFBdud6bBh2k/Q2d4k28SXK8wEUHyqc4B+h6WPLu1xgkXysxKi+cVPVrIa
	 w1KIlmTnZ3oFYHjEVj/fmwAmR5sf7VU8g7/l/61TYJmBPJMFMzI3Xx6dG96WgYdUaH
	 qqCVP3u6BSvGj7+4qYXGvPT7dz6XCCJ/3Erdf8uI0/JW0tUQVuqcOdcXFmSbMIz96P
	 iT0qvGAT2dS5g==
Date: Tue, 1 Aug 2023 14:26:13 +0200
From: Simon Horman <horms@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <ZMj55RwhJV2ATs66@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801062237.2687-3-jirislaby@kernel.org>

On Tue, Aug 01, 2023 at 08:22:37AM +0200, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


