Return-Path: <netdev+bounces-23195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D776B4AF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CAF1C20E51
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0D21507;
	Tue,  1 Aug 2023 12:25:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7721F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2EFC433C8;
	Tue,  1 Aug 2023 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690892757;
	bh=qDmS5AL4Z6d+/dt55lZBTzRFNXfWkRpgfk73IJyzw2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHiGs5TpDRAfQTKatB3QCQpE8QcBxTbjItfMQk0Ay7WKlmHRFSTv5X5wdhxFpthYj
	 oDPF/m4bqRv0xCoSFg5ixO7W7GtAEaMy3v2Pf+/oI11xr0hT04b/rfLz+XeCTn3myU
	 Fqio2i16zgTThIEN0BI0MQWeEK7SaBsZs7urM/GqUBQpHCQ9l+ZelAY1drjhoew2Z9
	 C6FwyTO+liNvaDeE22bjTJmAtt2uZ2RCrA8c8XP/9nUB1iNW+D+rZpcN7X2HIccroS
	 IHumSy5ClpiqEm4SZBR3XzXMOf40609V64D9LFoIbEGIssnn3mTqunn/PaYDgGg6AO
	 XSjaCcFg85kYA==
Date: Tue, 1 Aug 2023 14:25:53 +0200
From: Simon Horman <horms@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] can: can327: remove casts from tty->disc_data
Message-ID: <ZMj50QYDsFtf7jT8@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801062237.2687-2-jirislaby@kernel.org>

On Tue, Aug 01, 2023 at 08:22:36AM +0200, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


