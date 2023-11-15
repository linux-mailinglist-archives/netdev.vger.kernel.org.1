Return-Path: <netdev+bounces-47902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F247EBCAA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D561C20912
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA3A50;
	Wed, 15 Nov 2023 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWHlFi6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AB7E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCBC433C7;
	Wed, 15 Nov 2023 04:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700023771;
	bh=R44UjGh71TwSQypzLUusu2eLMm4bx2YXn7vey1p/UxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mWHlFi6ISVlEqfuNomqT29/0JBxGl6jgPp2V1fXNmsxjtjY58w36FCOEoIKo5mePX
	 PqMvD2bfTvERiX+Q2eS0Qw/i6Gs9EoKfaiKouwOx/xThH557f83uaM17K5PXi5zH85
	 nMVY+gR8uE/xmk8mdKzXkLl0U8Aru0EdCSk59JZE4IMX4j0lQTA1X2iw3oQtGe0XZf
	 kClw8XzhOjShn6WjPrvm6qpvIh0uxjOBtwj8tXEejJF2KLmivYXzZ03OBve9mfFyGO
	 j/C3Q3i+/KKLGxlUeNfABqKF09hgG7KsVQ07hFSbMGKdXglUycWe/WyOSAsm3EWosR
	 5lPcVT+5eri5Q==
Date: Tue, 14 Nov 2023 23:49:29 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v7 05/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20231114234929.038a5abc@kernel.org>
In-Reply-To: <169992179806.3867.8730181527639625952.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
	<169992179806.3867.8730181527639625952.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 16:29:58 -0800 Amritha Nambiar wrote:
> +      -
> +        name: napi-id
> +        doc: ID of the NAPI instance.
> +        type: u32

Similarly here, since we're describing a NAPI object - just "id"?

