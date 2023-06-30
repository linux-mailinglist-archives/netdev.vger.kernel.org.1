Return-Path: <netdev+bounces-14799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A25743E7E
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF54D1C20B8D
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DD1640F;
	Fri, 30 Jun 2023 15:17:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9E1640D
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A049C433C8;
	Fri, 30 Jun 2023 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688138277;
	bh=gnuxV5kzjS5tgTjg2uJ7Rw7C3mBNcN1hr74skn4arK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o9SK8k4m4GHJWiJr9nFXMiZOwiDOgCxqZa3NgvpDJ+mti0zgBVeSQLmiThea6rMjF
	 /DPPXenS1ln+915LJGR9aLe4tE7VqAFIuthSyxqNksbxMCki0eSlwIMFmldl5YNrWD
	 GhTF+Av65dMQfgtbTsdRe0H4TpqvqQFLvDr/FQOtpet/iov0JM5VVET0W0C8ZmXERz
	 5vr5aKZAeKFjThtyWIZw/1s+W34Wgo7EyB1djozuOi1EU8Wh+3wDyp2B3g+0A17Pe1
	 QtMzZUO+t1uExNXHAbqVQYNRgT0Bp/VhD6/1uM71r70oWjONjDbU88xhcqPOYf9kk4
	 3r76l+s9jycVg==
Date: Fri, 30 Jun 2023 08:17:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <andersson@kernel.org>, <quic_jhugo@quicinc.com>, "Sean Tranchetti"
 <quic_stranche@quicinc.com>
Subject: Re: [PATCH net v2] docs: networking: Update codeaurora references
 for rmnet
Message-ID: <20230630081756.609ba7fa@kernel.org>
In-Reply-To: <1688108686-16363-1-git-send-email-quic_subashab@quicinc.com>
References: <1688108686-16363-1-git-send-email-quic_subashab@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 01:04:46 -0600 Subash Abhinov Kasiviswanathan wrote:
> -https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/dataservices/tree/rmnetctl
> +The driver uses rtnl_link_ops for communication.
> \ No newline at end of file

Please add the new line at the end of the file.
-- 
pw-bot: cr

