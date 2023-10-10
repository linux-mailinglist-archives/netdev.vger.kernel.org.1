Return-Path: <netdev+bounces-39526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFA7BF95A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E045E1C20B53
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1E182D4;
	Tue, 10 Oct 2023 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vIGmcYfO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118D156D5
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:12:11 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B5A4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tiCdB9nrLFXzfwziGmnck3dOnp9nQBdChiePxm5tLQM=;
	t=1696936327; x=1698145927; b=vIGmcYfO1vpCSbWjJ1CgzpVs1UAtZywUlGAKv4Siv1mwsGE
	2z/mmC67rTlq+pXNi7y6n2XLzYgQCiCPb7KFKGlNR55HaomEx6CEaSAVogDJzqxiJ/Glpthri5ZfV
	7D2FrfSFdCLKzWrWKiNNG2360zwgslAZys3FnlZjL4OoafWd0DZhjWQpeP2u+oo8QEQrm6Wy1sc4W
	dxsrNTDQVdt431+8FUrBXVEHAUMqQ0sU7CC7w7JXDxbOdEBr1ly2PBDPaoVlGXFFesIomz5+WMnO4
	BUdI75XqZ641zdnVDIy4mNOErvelbmHFZHr1uoAX1nyBtjtxX6dy5jLF+qYl5G+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqAee-00000000ICh-32GR;
	Tue, 10 Oct 2023 13:12:00 +0200
Message-ID: <343fba1c7a9b53f37b87895b729fa73cad049826.camel@sipsolutions.net>
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com,  jacob.e.keller@intel.com
Date: Tue, 10 Oct 2023 13:11:59 +0200
In-Reply-To: <20231010110828.200709-3-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	 <20231010110828.200709-3-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 13:08 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Introduce support for forgotten attribute type bitfield32.
> Note that since the generated code works with struct nla_bitfiel32,
                                                                  ^ typo

Otherwise, looks good.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

