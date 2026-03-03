Return-Path: <netdev+bounces-263467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZGAXJNZyp2ljhgAAu9opvQ
	(envelope-from <netdev+bounces-263467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:46:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D721F872A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 182EF30774C4
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD0267B07;
	Tue,  3 Mar 2026 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKTtk2kX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC53368B7
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581587; cv=none; b=aCs7geYJb1ZAxrqQRbg2C/xt4YM3A54gq264wgerZucA/47LGUm+ZASUggz6bFD70IPDWX0VpAyhCke0AckOt9fBxy9sCn+s9bxwYIRhQavYyG1jsSV+2JxcFqGvbqEors2M37vlXxhGCaiuVwQH0tdtaBhVjVpHPOHSH33re4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581587; c=relaxed/simple;
	bh=gmBtsUjerG61SRCQ734yxFIH0o6o8shvEP94oudXQ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXPjRDCCVxKEVs4kvncxivajXU2bWNpSmyjKqHPatqjJSQFw0mc5DnuXsHjFUyYbgzran4U9hx/e87Lm5jr6KN0hysAvhAgKqiVMpLeZ9SS9W7HwKfwXGYck40CCwJolZ8+RrJ8YyawbOW0xaLgaBSzuI4Ur1YqJxd4CxhjylbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKTtk2kX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E2C116C6;
	Tue,  3 Mar 2026 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581587;
	bh=gmBtsUjerG61SRCQ734yxFIH0o6o8shvEP94oudXQ0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKTtk2kX7PH1rd1pujUhvKTS3UzTrvZ7sxEmqtEv3xU4WKqn+Zw5k4rXfA7GIn1rh
	 Q1dS6MIwp9KVnC09xianyUvEs0b43A1zdvpxAj7Sxk6nQFgGafVpJwMp46gyL4XDjf
	 TxJPbnn7vj/jfCJIp7da+oc2tevSk0bjUzSKajdOCyr7ZYTm488V1kmMUxW8CxlKbX
	 eMlQz+ItfZQH8oLjRZOenwnCGDqOc7+A1ifu36P56V93EkA21nuH9d3+chXijdf84U
	 u3CWQrJvhP4w2ij32Sr3Ah955m5J9mBuFyX4S+zmqBY9gZhcJK8u6mH6q84tA7oyWM
	 iJ2x8V/o1wqEA==
Date: Tue, 3 Mar 2026 15:46:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Joe Damato <joe@dama.to>, Wei Wang
 <weibunny@meta.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v2 2/4] selftests/net: Export Netlink class via
 lib.py
Message-ID: <20260303154625.5b8092a9@kernel.org>
In-Reply-To: <20260302053315.1919859-3-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
	<20260302053315.1919859-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3D721F872A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-263467-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 21:33:13 -0800 David Wei wrote:
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index 32c223e93b2c..a52b067f7589 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -13,14 +13,14 @@ try:
>          SPEC_PATH = KSFT_DIR / "net/lib/specs"
>  
>          sys.path.append(tools_full_path.as_posix())
> -        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
> +        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink

index a52b067f7589..b42986bf39e3 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -27,6 +27,12 @@ from .ksft import ksft_pr, ktap_result
     ktap_result(True, comment="SKIP")
     sys.exit(4)
 
+__all__ = [
+    "NlError", "Netlink", "YnlFamily", "SPEC_PATH",
+    "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily",
+    "NetdevFamily", "NetshaperFamily", "DevlinkFamily", "PSPFamily",
+]
+
 #
 # Wrapper classes, loading the right specs
 # Set schema='' to avoid jsonschema validation, it's slow

