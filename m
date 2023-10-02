Return-Path: <netdev+bounces-37480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FB7B589C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8616B1C2074D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754551DDD9;
	Mon,  2 Oct 2023 17:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693A1A73C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51544C433C8;
	Mon,  2 Oct 2023 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696266509;
	bh=QhZMAI126QClwacmWOKLD4jWk8FlpCqWOmI7dE0bK6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvA06LhhNHDC6Y/ei2TPiBij5XUvK/9fFeEYW1KOBl7vetU1KwPB53gc9RY5Z7DGY
	 gLsUVLeCApbij7oTvfncE7qxjWGct0Ivdvu0DU5hW9o2UWf0aeoxqaFmsCPGl0yQ7/
	 36nc1CoCnnJ67wOJYDidtR+nkoTmOjFaC0r0HGToLN5V8XJ6+IvcA85JxNnFaW6YEr
	 b4UJjH1RKtmTelaX+qPbjqK/QgSrTlP0R2GjJEVLew8nUKzMonkYt43ibjtDnZk1e4
	 nmUF6pbvVF+tnbT1vReW8hykp5M8cgLPYmIF3v5jWp29hM04M1M28wN4S8PpsB/bLz
	 Tabp0RhhFeIoA==
Date: Mon, 2 Oct 2023 19:08:24 +0200
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Spelling s/preceeding/preceding/g
Message-ID: <20231002170824.GB92317@kernel.org>
References: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>

On Thu, Sep 28, 2023 at 02:18:33PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>


