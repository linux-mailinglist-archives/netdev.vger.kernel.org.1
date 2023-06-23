Return-Path: <netdev+bounces-13364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBC73B585
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89413281AD2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6081385;
	Fri, 23 Jun 2023 10:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1400211F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:37:45 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E75273B;
	Fri, 23 Jun 2023 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lk442Og9qeSuSAMtnFnHXSps46eB9vX+oT9sJwzVZUI=;
	t=1687516628; x=1688726228; b=rq5bX+DOoTX2QnoAPE1GARiXl9V3H5DCitMRncFeT4zT8+f
	3VhnaJWnATEKIo4071AgtZ1OOWRrjXBVOXchZufuPAZ/HwbXq07yUYOuInhTc8Ax4nnIq8r/HKqMc
	nIw+lMkNqbsIsw2f4Iebh/fIZ1/YAOHemBM4Wf0mWrvSJ05zAFWu1HzBTsv0cvX8ssc1nW6fEqyo/
	l8/SkCW8KuKeBQX9ovadC+v0wKw/vXsH2o0oq/Mfx6wforJlchNlwJTPsKsfW3pyNpmMYYJKhuatx
	ySNNYDa6eCD+2WK2AjUQnOhXV4kRYrZI/sO87WfjQ7DSgYVABHgqZeVM5g+X9JXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qCe9m-00FgPV-1a;
	Fri, 23 Jun 2023 12:36:46 +0200
Message-ID: <19d17ee302892f48f9b6110ec6c2ccccf0c1b9ef.camel@sipsolutions.net>
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
From: Johannes Berg <johannes@sipsolutions.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jakub Kicinski <kuba@kernel.org>
Cc: jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com, 
 davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
 pabeni@redhat.com,  apw@canonical.com, joe@perches.com,
 linux-rdma@vger.kernel.org,  netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,  linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Jun 2023 12:36:44 +0200
In-Reply-To: <50a88781b9e2a80588438c315167bbec@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
	 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
	 <50a88781b9e2a80588438c315167bbec@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-23 at 08:51 +0000, Yueh-Shun Li wrote:
>=20
> >   - [3/8] zd1211rw: fix comment typo
> >     (no matching commit)
>=20
> Should I rebase the local branch onto netdev/net-next/main
> and send the "no matching commit" patches again?
>=20

The wireless one is on our radar, no need to resend.

But: https://lore.kernel.org/r/87y1kncuh4.fsf@kernel.org

johannes

