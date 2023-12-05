Return-Path: <netdev+bounces-53902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC538052BA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC9B1C20E68
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF269783;
	Tue,  5 Dec 2023 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CppEzKCu"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3401FF5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VsrbVTJtRC3FIDWomR0OCY7CiDkedpBKj68ACEtmZeY=;
	t=1701775479; x=1702985079; b=CppEzKCul75LXkN+WspPOXlVPopp82KY1RUu2LR6dq4rNgv
	lHpNji/l0ApumdSBp/UaSynLDDVBrKswIi/pJRAl9y1/TdYZ7R2ueFI/cGG+IQW+s62QK8DgvDJ7a
	vqbwltnAYnISA0EI8EVBXLAxN2J9QZAdMEznBLk9aVOozR3clT1UkP30hCB4dtJxY2+29qgicfZOn
	9yfCxK2aUpX0IlKmC0ugtEjOCI/ppHGoTKBNC5L36JCNvXcr9y8+JMLGQt05wlmHXSz90ly0fDwM8
	MBEL/DoDoYwA7F6La5qnJ4gQh9T+OvcIdSDeyydMHgJNqasAGLJ7A0Vy5wIp/oVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rATX6-0000000GFoc-2Qoa;
	Tue, 05 Dec 2023 12:24:08 +0100
Message-ID: <30b09a2160274f8ad2d04f2e1b64cafaafcc882b.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: rtnetlink: remove local list in
 __linkwatch_run_queue()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Date: Tue, 05 Dec 2023 12:24:07 +0100
In-Reply-To: <ZW8ICbik45ODsRUW@nanopsycho>
References: 
	<20231204211952.01b2d4ff587d.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
	 <ZW8ICbik45ODsRUW@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-05 at 12:22 +0100, Jiri Pirko wrote:
> Mon, Dec 04, 2023 at 09:19:53PM CET, johannes@sipsolutions.net wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
>=20
> Why rfc?

I thought maybe someone could come up with a reason it actually makes
sense? :)

johannes

