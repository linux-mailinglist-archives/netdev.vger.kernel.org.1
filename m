Return-Path: <netdev+bounces-78068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A4873FBA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6013D1C2280F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D513E7C1;
	Wed,  6 Mar 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWQ0hRUm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10F13774C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749941; cv=none; b=Cu/J1950DlDU4kcz4tMT5S6hTjnw9fmU8yKzVb7O+cs7Ht51SjLA2n47bade9g8sDrLZpZ2A2RBM9onrtwEnzsNX8VTEwFf47B0wvy1ydiSv5d/EkWudPiclhT/tCvMsewVcDFotXdAef73y21T02kRP1qShMJERIJqNuFRyrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749941; c=relaxed/simple;
	bh=ojygEvnyVApcE1y/QhKKUDNO/RQe0ORdhTlEo55f6sU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBsTtHXL5W2J4WtP2mA40DGtBPGZE3lk2qDG1tMk7iVTxmbx9n+o7x0AOrLk/SPFhg+hkecMtd7xYpZONL35XlK/7HlY8xe4aOMM6N0lBQZdxUoDcqznKW4Ak5nqh/t5xXfLh97HaELmC2MapFNOOmmvBoTltzNlkkC4Z+5ikFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWQ0hRUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A69C433C7;
	Wed,  6 Mar 2024 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709749940;
	bh=ojygEvnyVApcE1y/QhKKUDNO/RQe0ORdhTlEo55f6sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWQ0hRUml73okKu+Zr6/Pss4OH4EoOnEsN8b+FfCYkQ9gYo1Nx1m0XHykOg1z8dM5
	 teMMlS4gCFGAp1eBUI0Wsbuc/AVxGgLKfIhdn7aQ7ZcPrBbTL3vEtZHR+p5qIShFkB
	 g72olS0ZjiMcRlJSmZNy3KIBCUfs6zIuCNjExZojZVcsBGWZCTeLLlGQKYmeHevH4u
	 NuAh5v5qMqKGcEDxBxXlvVkJ2xq9x4oYdhudohtcbK784+iOPUzpQGDlrPVRHWU65N
	 34aG7zE0q5AEsthflUv9m08MG284qLsZPc/nuHl3J3ATT95+1mwd0cxkvk1oVnZ7SQ
	 Ovf6taraZiQbw==
Date: Wed, 6 Mar 2024 10:32:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 0/5] tools/net/ynl: Add support for nlctrl
 netlink family
Message-ID: <20240306103219.0a2a29e0@kernel.org>
In-Reply-To: <20240306125704.63934-1-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:56:59 +0000 Donald Hunter wrote:
> This series adds a new YNL spec for the nlctrl family, plus some fixes
> and enhancements for ynl.
> 
> Patch 1 fixes an extack decoding bug
> Patch 2 gives cleaner netlink error reporting
> Patch 3 fixes an array-nest codegen bug
> Patch 4 adds nest-type-value support to ynl
> Patch 5 contains the nlctrl spec

Somewhat incredibly the C seems to work, I tested with this sample:

// SPDX-License-Identifier: GPL-2.0
#include <stdio.h>
#include <string.h>

#include <ynl.h>

#include "nlctrl-user.h"

int main(int argc, char **argv)
{
	struct nlctrl_getfamily_list *fams;
	struct ynl_error yerr;
	struct ynl_sock *ys;
	char *name;

	ys = ynl_sock_create(&ynl_nlctrl_family, &yerr);
	if (!ys) {
		fprintf(stderr, "YNL: %s\n", yerr.msg);
		return 1;
	}

	printf("Select family ($name; or 0 = dump): ");
	scanf("%ms", &name);

	if (!name || !strcmp(name, "0")) {
		fams = nlctrl_getfamily_dump(ys);
		if (!fams)
			goto err_close;

		ynl_dump_foreach(fams, f)
			printf("%d: %s\n", f->family_id, f->family_name);
		nlctrl_getfamily_list_free(fams);
	} else {
		struct nlctrl_getfamily_req *req;
		struct nlctrl_getfamily_rsp *f;

		req = nlctrl_getfamily_req_alloc();
		nlctrl_getfamily_req_set_family_name(req, name);

		f = nlctrl_getfamily(ys, req);
		nlctrl_getfamily_req_free(req);
		if (!f)
			goto err_close;

		printf("%d: %s\n", f->family_id, f->family_name);
		nlctrl_getfamily_rsp_free(f);
	}
	free(name);

	ynl_sock_destroy(ys);
	return 0;

err_close:
	fprintf(stderr, "YNL: %s\n", ys->err.msg);
	ynl_sock_destroy(ys);
	return 2;
}

