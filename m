Return-Path: <netdev+bounces-281406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI0CDbmP72mhCwEAu9opvQ
	(envelope-from <netdev+bounces-281406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D119476707
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA92B30027B1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009B30C62E;
	Mon, 27 Apr 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="YmYDheG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E7359A65
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307519; cv=none; b=eBBaHAPcLj/OcRdEInot9FZhk6bOtLX7+W/8a7rFsucxdWjFFnTtmI/LFuURIf6jNaukB8n8G+yD5SBoQ1c0E5URRf8WUZ3thpYwXNLLNfCEp4N3a3WJE1NxmwhnMxOWDBL3nn3jNpbZH2+vQHs1yiSNXzF/FLKdXhsLwnX0fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307519; c=relaxed/simple;
	bh=KYB6ODKljVgEhnTiOTVthv80e4BIH2V2LRZmASHPFDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rejJ5QB7ok+TB6wCdMU8xz5O8BgcMTbDWNLmSQsD//2qBqUhxsqvGPAAlIMYFVbO/Cttm1MOAncvbs1LtmDPUHHBLi6nFFsia6Zjvo+dYVoV5T5nSG2Aa4mxjl0FmRYcg1SIucEbKv5eYTNiRwu6aKac+sGEIrYJC3aVW9Buaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=YmYDheG0; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de4be15125so3555638a34.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777307516; x=1777912316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76hTmtSlcXffZppt8qpE+WvVIj+9utjAzzW/EoAw2Zw=;
        b=YmYDheG0hCg3stiJQYRb2iUAypg7Q6xXW6H5ZHkjsem0y00505Urq6ENTDMSMfPnD+
         KpfrEHsHf52NHMLTgq35i/Pyz/oT/sgW1tgZRxZob4Tz/k1/6qOx0DSWakSIruMfW9um
         IyRq7gIHAgsSExKzFLO5p5i1LdRRvupqVg2CznpEJezwY7ZrwV3zQDfBtHJS1JjUCBVv
         COVU1EmYmCbxaqMUgKMWA0CGRgzlUmeS/Qtbh/dzqeOyn/U/+XqwELLZ87hMzupRSZYT
         A1X3MqnAFUvD8zEH+DfeXOXec6K8v5MjhfMY9blfYGLY3H40mzUDREBuE6puAXPukkp/
         z3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307516; x=1777912316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76hTmtSlcXffZppt8qpE+WvVIj+9utjAzzW/EoAw2Zw=;
        b=UbQX5ifYeuaLtZAwCtgdzy6cKBxRS/p6WL8uttqaG2qYSgcG9yhZjegiIWxANsn3wD
         GAWKT5hYArEy8D/dTLIVgtW8EhoFWKG1GWp+b1tCSKLzRJav7JEBphIvfUFT8BBW7DvM
         6uxa8M8qDEEZZ0kmOosp6UjnecgJw6q13k0yap1We/Xs3u+xXPcevqiMWsF/wMIwF2K6
         8yKLux1BdbEC6Fh7hwShH0cM5FhmFF24YQXgxQbQzx/kvXF+agLEsK/G6lPimklIJ+28
         qCP+mbRUj6b/Pcw1On+/9upIVelf+IUC/3aA9Doh11SdKNOaouMcEmqN7HNAhbB8cTl2
         sxfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ulMoSH6FZzRhVREaIKONWb81BMfYt2s71Lm6OwjI0LkeRHdgyaci90FxzZqF+ms+caV8nzAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxh6j2j8OpOYUplzFNnmD7/XQUKEP4zlhDIeIW9eniGcKO6VsA
	x8BfK9VGpxp5kMPFTnesiqvIjl3w/YgtCdMZtuXDx4ECEtJAzFpQKwFphmlUSNfSQkI=
X-Gm-Gg: AeBDieu6/Nomq4udWXxbNFlBXFnSFHTwAyUnu4Hg19IqL0rxg2h1NFyi3n/MaNhIOUO
	djipuXUybw1aoMIFlbaO3mfKQXkWg+SQYX1T8T0tlf1OIwZnhKZEC7u+bl8LkY+qNXr1uum61qA
	WQyOX+3JaAO/BJ3afv0P7rT4JmJfVOUXQoffPma1RHqtCHlcO9lD02l9xikHrVNdGhdXmwHu1eL
	GBZ92pOmC3WqDrp+u5cLs5eaHZGoBAIL6G0WnrTLtKZ1qIwp7wVGytfcClDTl9J8SU8qyA8Eetv
	cE8E4qRRWrv7q9yJWINK86K9cpKRrOoAdiUqj9HCUiYjVq3XWuNSX9BmQKoojOqv2Lpk5e+0e4a
	H/dr69rr5kzKaM7cguuXyP/5DqkREZl3m6kCSjvsNpmAsTgLXqDvWzovEVn9gyCRgAsfgiMDJ2e
	0l/Nt5qUq6H7ojR63NfPWsKYwEC4HWLepzuIZkorTsiReBew==
X-Received: by 2002:a05:6808:80b3:b0:479:d937:c4f4 with SMTP id 5614622812f47-479d937d218mr20314907b6e.19.1777307515957;
        Mon, 27 Apr 2026 09:31:55 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f6705d7asm13039358b6e.10.2026.04.27.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:31:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:31:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
Message-ID: <20260427093149.2cb7a215@phoenix.local>
In-Reply-To: <20260427081953.364819-1-edumazet@google.com>
References: <20260427081953.364819-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7D119476707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281406-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:email]

On Mon, 27 Apr 2026 08:19:53 +0000
Eric Dumazet <edumazet@google.com> wrote:

> Some fflush() calls only make sense for monitor programs.
>=20
> For other cases, forcing a flush is expensive.
>=20
> After this patch, ip, tc and ss are correctly buffering most of their
> output when redirected to a file.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>

What about pulling all the fflush from the leaf calls, and move the fflush
to one common place. There are some of these that need to come back
like the addr flush loop, this is just a semi-automated first pass.

=46rom 815ed9eb987fc458987e753b3a2fa1786578b485 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 27 Apr 2026 09:26:58 -0700
Subject: [PATCH] flush stdout only in monitor mode

As Eric pointed out fflush() only makes sense in monitor mode.
In other modes buffering the output helps with large outputs
like route dumps.

Move the fflush() into rtnl_listen() which is the common code
used by all monitoring subcommands.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/fdb.c      | 2 --
 bridge/link.c     | 2 --
 bridge/mdb.c      | 1 -
 bridge/mst.c      | 1 -
 bridge/vlan.c     | 4 ----
 bridge/vni.c      | 2 --
 genl/ctrl.c       | 2 --
 ip/ipaddress.c    | 8 --------
 ip/ipfou.c        | 1 -
 ip/ipila.c        | 1 -
 ip/ipioam6.c      | 1 -
 ip/ipl2tp.c       | 2 --
 ip/iplink.c       | 2 --
 ip/ipmptcp.c      | 6 ------
 ip/ipmroute.c     | 1 -
 ip/ipneigh.c      | 4 ----
 ip/ipnetconf.c    | 1 -
 ip/ipnetns.c      | 1 -
 ip/ipnexthop.c    | 6 ------
 ip/ipntable.c     | 2 --
 ip/ipprefix.c     | 1 -
 ip/iproute.c      | 4 ----
 ip/iprule.c       | 1 -
 ip/ipseg6.c       | 1 -
 ip/ipstats.c      | 2 --
 ip/iptoken.c      | 2 --
 ip/iptuntap.c     | 1 -
 ip/rtmon.c        | 1 -
 ip/tcp_metrics.c  | 4 ----
 ip/xfrm_monitor.c | 5 -----
 ip/xfrm_policy.c  | 2 --
 ip/xfrm_state.c   | 1 -
 lib/libnetlink.c  | 2 ++
 tc/tc_class.c     | 1 -
 tc/tc_filter.c    | 1 -
 tc/tc_qdisc.c     | 1 -
 36 files changed, 2 insertions(+), 78 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d57b5750..05f093b5 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -309,7 +309,6 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 	print_string(PRINT_ANY, "state", "%s\n",
 			   state_n2a(r->ndm_state));
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
@@ -417,7 +416,6 @@ static int fdb_show(int argc, char **argv)
 		exit(1);
 	}
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/bridge/link.c b/bridge/link.c
index 1c8faa85..7638797d 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -292,7 +292,6 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
@@ -669,7 +668,6 @@ static int brlink_show(int argc, char **argv)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
diff --git a/bridge/mdb.c b/bridge/mdb.c
index 72490971..112deeb9 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -501,7 +501,6 @@ static int mdb_show(int argc, char **argv)
=20
 	close_json_object();
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/bridge/mst.c b/bridge/mst.c
index 37362c45..8e46c762 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -158,7 +158,6 @@ static int mst_show(int argc, char **argv)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
diff --git a/bridge/vlan.c b/bridge/vlan.c
index 3c240207..27d31ba8 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -756,7 +756,6 @@ static int print_vlan_stats(struct nlmsghdr *n, void *a=
rg)
 	struct if_stats_msg *ifsm =3D NLMSG_DATA(n);
 	struct rtattr *tb[IFLA_STATS_MAX+1];
 	int len =3D n->nlmsg_len;
-	FILE *fp =3D arg;
=20
 	len -=3D NLMSG_LENGTH(sizeof(*ifsm));
 	if (len < 0) {
@@ -778,7 +777,6 @@ static int print_vlan_stats(struct nlmsghdr *n, void *a=
rg)
 		print_vlan_stats_attr(tb[IFLA_STATS_LINK_XSTATS_SLAVE],
 				      ifsm->ifindex);
=20
-	fflush(fp);
 	return 0;
 }
=20
@@ -1205,7 +1203,6 @@ static int vlan_show(int argc, char **argv, int subje=
ct)
=20
 out:
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
@@ -1260,7 +1257,6 @@ static int vlan_global_show(int argc, char **argv)
 		close_vlan_port();
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
diff --git a/bridge/vni.c b/bridge/vni.c
index 57b04c8c..b28647fd 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -333,7 +333,6 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 	if (opened)
 		close_vni_port();
=20
-	fflush(stdout);
 	return 0;
 }
=20
@@ -381,7 +380,6 @@ static int vni_show(int argc, char **argv)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
diff --git a/genl/ctrl.c b/genl/ctrl.c
index 9412c2f0..88ff4cb8 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -275,7 +275,6 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 	struct genlmsghdr *ghdr =3D NLMSG_DATA(n);
 	int len =3D n->nlmsg_len;
 	struct rtattr *attrs;
-	FILE *fp =3D (FILE *) arg;
=20
 	if (n->nlmsg_type !=3D  GENL_ID_CTRL) {
 		fprintf(stderr, "Not a controller message, nlmsg_len=3D%d "
@@ -339,7 +338,6 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 	if (tb[CTRL_ATTR_MCAST_GROUPS])
 		print_ctrl_mcast(tb[CTRL_ATTR_MCAST_GROUPS]);
=20
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 4d93a04a..f538bf88 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -894,7 +894,6 @@ static int print_linkinfo_brief(FILE *fp, const char *n=
ame,
 		print_string(PRINT_FP, NULL, "%s", "\n");
 	}
=20
-	fflush(fp);
 	return 0;
 }
=20
@@ -1346,7 +1345,6 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	}
=20
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
 	/* prettier here if stderr and stdout go to the same place */
 	if (truncated_vfs)
 		fprintf(stderr, "Truncated VF list: %s\n", name);
@@ -1732,7 +1730,6 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 	}
 	print_string(PRINT_FP, NULL, "%s", "\n");
 brief_exit:
-	fflush(fp);
 	return 0;
 }
=20
@@ -1768,7 +1765,6 @@ static int print_selected_addrinfo(struct ifinfomsg *=
ifi,
=20
 	if (brief) {
 		print_string(PRINT_FP, NULL, "%s", "\n");
-		fflush(fp);
 	}
 	return 0;
 }
@@ -2006,7 +2002,6 @@ static int ipaddr_flush(void)
 				else
 					printf("*** Flush is complete after %d round%s ***\n", round, round >=
 1?"s":"");
 			}
-			fflush(stdout);
 			return 0;
 		}
 		round++;
@@ -2015,7 +2010,6 @@ static int ipaddr_flush(void)
=20
 		if (show_stats) {
 			printf("\n*** Round %d, deleting %d addresses ***\n", round, filter.flu=
shed);
-			fflush(stdout);
 		}
=20
 		/* If we are flushing, and specifying primary, then we
@@ -2027,7 +2021,6 @@ static int ipaddr_flush(void)
 			goto flush_done;
 	}
 	fprintf(stderr, "*** Flush remains incomplete after %d rounds. ***\n", ma=
x_flush_loops);
-	fflush(stderr);
 	return 1;
 }
=20
@@ -2351,7 +2344,6 @@ static int ipaddr_list_flush_or_save(int argc, char *=
*argv, int action)
 			print_link_stats(stdout, n);
 		close_json_object();
 	}
-	fflush(stdout);
=20
 out:
 	free_nlmsg_chain(ainfo);
diff --git a/ip/ipfou.c b/ip/ipfou.c
index 760cfee2..8c1e061a 100644
--- a/ip/ipfou.c
+++ b/ip/ipfou.c
@@ -322,7 +322,6 @@ static int do_show(int argc, char **argv)
 		return 1;
 	}
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/ip/ipila.c b/ip/ipila.c
index 80f34f29..2590de9a 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -159,7 +159,6 @@ static int do_list(int argc, char **argv)
 		return 1;
 	}
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/ip/ipioam6.c b/ip/ipioam6.c
index 18860989..118fcd1c 100644
--- a/ip/ipioam6.c
+++ b/ip/ipioam6.c
@@ -261,7 +261,6 @@ static int ioam6_do_cmd(void)
 			exit(1);
 		}
 		delete_json_obj();
-		fflush(stdout);
 	}
=20
 	return 0;
diff --git a/ip/ipl2tp.c b/ip/ipl2tp.c
index 87a4b898..97f7ff08 100644
--- a/ip/ipl2tp.c
+++ b/ip/ipl2tp.c
@@ -467,7 +467,6 @@ static int get_session(struct l2tp_data *p)
 		exit(1);
 	}
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
@@ -502,7 +501,6 @@ static int get_tunnel(struct l2tp_data *p)
 		exit(1);
 	}
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/ip/iplink.c b/ip/iplink.c
index fce6631d..eae51438 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1296,7 +1296,6 @@ static void print_mpls_stats(FILE *fp, struct rtattr =
*attr)
 	print_nl();
 	print_mpls_link_stats(fp, stats, "        ");
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
 }
=20
 static void print_af_stats_attr(FILE *fp, int ifindex, struct rtattr *attr)
@@ -1359,7 +1358,6 @@ static int print_af_stats(struct nlmsghdr *n, void *a=
rg)
 	if (tb[IFLA_STATS_AF_SPEC])
 		print_af_stats_attr(fp, ifsm->ifindex, tb[IFLA_STATS_AF_SPEC]);
=20
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 3df89db5..02cf72ce 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -276,7 +276,6 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
=20
 	print_nl();
 	close_json_object();
-	fflush(stdout);
=20
 	return 0;
 }
@@ -320,12 +319,10 @@ static int mptcp_addr_dump(void)
 	if (rtnl_dump_filter(&genl_rth, print_mptcp_addr, stdout) < 0) {
 		fprintf(stderr, "Dump terminated\n");
 		delete_json_obj();
-		fflush(stdout);
 		return -2;
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
@@ -349,7 +346,6 @@ static int mptcp_addr_show(int argc, char **argv)
 	ret =3D print_mptcp_addr(answer, stdout);
 	delete_json_obj();
 	free(answer);
-	fflush(stdout);
 	return ret;
 }
=20
@@ -430,7 +426,6 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *=
arg)
=20
 	print_nl();
 	close_json_object();
-	fflush(stdout);
=20
 	return 0;
 }
@@ -592,7 +587,6 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctr=
l,
 out:
 	print_nl();
 	close_json_object();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/ip/ipmroute.c b/ip/ipmroute.c
index c540eab1..164632e6 100644
--- a/ip/ipmroute.c
+++ b/ip/ipmroute.c
@@ -206,7 +206,6 @@ int print_mroute(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", NULL);
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipneigh.c b/ip/ipneigh.c
index e678545a..b21fd637 100644
--- a/ip/ipneigh.c
+++ b/ip/ipneigh.c
@@ -298,7 +298,6 @@ static int print_neigh_brief(FILE *fp, struct ndmsg *r,=
 struct rtattr *tb[])
=20
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	close_json_object();
-	fflush(fp);
=20
 	return 0;
 }
@@ -472,7 +471,6 @@ int print_neigh(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
=20
 	return 0;
 }
@@ -630,7 +628,6 @@ static int do_show_or_flush(int argc, char **argv, int =
flush)
 					else
 						printf("*** Flush is complete after %d round%s ***\n", round, round =
> 1?"s":"");
 				}
-				fflush(stdout);
 				return 0;
 			}
 			round++;
@@ -638,7 +635,6 @@ static int do_show_or_flush(int argc, char **argv, int =
flush)
 				exit(1);
 			if (show_stats) {
 				printf("\n*** Round %d, deleting %d entries ***\n", round, filter.flus=
hed);
-				fflush(stdout);
 			}
 			filter.state &=3D ~NUD_FAILED;
 		}
diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 020eff78..57bb99d1 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -140,7 +140,6 @@ int print_netconf(struct rtnl_ctrl_data *ctrl, struct n=
lmsghdr *n, void *arg)
=20
 	close_json_object();
 	print_string(PRINT_FP, NULL, "\n", NULL);
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 3a33a3ad..587534ae 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -327,7 +327,6 @@ int print_nsid(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", NULL);
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index d5c42936..14b525aa 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -826,7 +826,6 @@ int print_cache_nexthop(struct nlmsghdr *n, void *arg, =
bool process_cache)
=20
 	__print_nexthop_entry(fp, NULL, &nhe, n->nlmsg_type =3D=3D RTM_DELNEXTHOP=
);
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
=20
 	if (process_cache)
 		ipnh_cache_process_nlmsg(n, &nhe);
@@ -882,7 +881,6 @@ int print_nexthop_bucket(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	close_json_object();
-	fflush(fp);
=20
 	return 0;
 }
@@ -1178,7 +1176,6 @@ static int ipnh_get_id(__u32 id)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
=20
 	free(answer);
=20
@@ -1266,7 +1263,6 @@ static int ipnh_list_flush(int argc, char **argv, int=
 action)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
@@ -1342,7 +1338,6 @@ static int ipnh_bucket_list(int argc, char **argv)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
@@ -1383,7 +1378,6 @@ static int ipnh_bucket_get_id(__u32 id, __u16 bucket_=
index)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
=20
 	free(answer);
=20
diff --git a/ip/ipntable.c b/ip/ipntable.c
index 54db9b62..51fa067c 100644
--- a/ip/ipntable.c
+++ b/ip/ipntable.c
@@ -532,7 +532,6 @@ static void print_ndtstats(const struct ndt_stats *ndts)
=20
 static int print_ntable(struct nlmsghdr *n, void *arg)
 {
-	FILE *fp =3D (FILE *)arg;
 	struct ndtmsg *ndtm =3D NLMSG_DATA(n);
 	int len =3D n->nlmsg_len;
 	struct rtattr *tb[NDTA_MAX+1];
@@ -633,7 +632,6 @@ static int print_ntable(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
=20
 	return 0;
 }
diff --git a/ip/ipprefix.c b/ip/ipprefix.c
index 4ec30524..5704f2f9 100644
--- a/ip/ipprefix.c
+++ b/ip/ipprefix.c
@@ -81,7 +81,6 @@ int print_prefix(struct nlmsghdr *n, void *arg)
 	}
=20
 	fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
diff --git a/ip/iproute.c b/ip/iproute.c
index c2538894..820e8701 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1012,7 +1012,6 @@ int print_route(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", NULL);
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
@@ -1781,7 +1780,6 @@ static int iproute_flush(int family, rtnl_filter_t fi=
lter_fn)
 					printf("*** Flush is complete after %d round%s ***\n",
 					       round, round > 1 ? "s" : "");
 			}
-			fflush(stdout);
 			return 0;
 		}
 		round++;
@@ -1798,7 +1796,6 @@ static int iproute_flush(int family, rtnl_filter_t fi=
lter_fn)
 		if (show_stats) {
 			printf("\n*** Round %d, deleting %d entries ***\n",
 			       round, filter.flushed);
-			fflush(stdout);
 		}
 	}
 }
@@ -2035,7 +2032,6 @@ static int iproute_list_flush_or_save(int argc, char =
**argv, int action)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
 	return 0;
 }
=20
diff --git a/ip/iprule.c b/ip/iprule.c
index 3af02da2..b56b1b18 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -599,7 +599,6 @@ int print_rule(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/ipseg6.c b/ip/ipseg6.c
index 305b8961..efd37227 100644
--- a/ip/ipseg6.c
+++ b/ip/ipseg6.c
@@ -197,7 +197,6 @@ static int seg6_do_cmd(void)
 			exit(1);
 		}
 		delete_json_obj();
-		fflush(stdout);
 	}
=20
 	return 0;
diff --git a/ip/ipstats.c b/ip/ipstats.c
index f0f8dcdc..8a2ac85e 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -879,7 +879,6 @@ static int ipstats_dump(struct ipstats_stat_enabled *en=
abled)
 		rc =3D -2;
 	}
=20
-	fflush(stdout);
 	return rc;
 }
=20
@@ -1355,6 +1354,5 @@ int ipstats_print(struct nlmsghdr *n, void *arg)
 	if (rc)
 		return rc;
=20
-	fflush(fp);
 	return 0;
 }
diff --git a/ip/iptoken.c b/ip/iptoken.c
index f25a7c8b..8bd9b4dc 100644
--- a/ip/iptoken.c
+++ b/ip/iptoken.c
@@ -41,7 +41,6 @@ static void usage(void)
 static int print_token(struct nlmsghdr *n, void *arg)
 {
 	struct rtnl_dump_args *args =3D arg;
-	FILE *fp =3D args->fp;
 	int ifindex =3D args->ifindex;
 	struct ifinfomsg *ifi =3D NLMSG_DATA(n);
 	int len =3D n->nlmsg_len;
@@ -85,7 +84,6 @@ static int print_token(struct nlmsghdr *n, void *arg)
 			   "ifname", "%s\n",
 			   ll_index_to_name(ifi->ifi_index));
 	close_json_object();
-	fflush(fp);
=20
 	return 0;
 }
diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index 6718ec6c..0f46fe6a 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -444,7 +444,6 @@ static int do_show(int argc, char **argv)
 	}
=20
 	delete_json_obj();
-	fflush(stdout);
=20
 	return 0;
 }
diff --git a/ip/rtmon.c b/ip/rtmon.c
index 470f4ba6..507a80da 100644
--- a/ip/rtmon.c
+++ b/ip/rtmon.c
@@ -46,7 +46,6 @@ static int dump_msg(struct rtnl_ctrl_data *ctrl,
 	if (!init_phase)
 		write_stamp(fp);
 	fwrite((void *)n, 1, NLMSG_ALIGN(n->nlmsg_len), fp);
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/tcp_metrics.c b/ip/tcp_metrics.c
index 9c8fb072..09943f42 100644
--- a/ip/tcp_metrics.c
+++ b/ip/tcp_metrics.c
@@ -156,7 +156,6 @@ static void print_tcp_metrics(struct rtattr *a)
=20
 static int process_msg(struct nlmsghdr *n, void *arg)
 {
-	FILE *fp =3D (FILE *) arg;
 	struct genlmsghdr *ghdr;
 	struct rtattr *attrs[TCP_METRICS_ATTR_MAX + 1], *a;
 	const char *h;
@@ -334,7 +333,6 @@ static int process_msg(struct nlmsghdr *n, void *arg)
=20
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
@@ -477,7 +475,6 @@ static int tcpm_do_cmd(int cmd, int argc, char **argv)
 				} else if (show_stats)
 					printf("*** Flush is complete after %d round%s ***\n",
 					       round, round > 1 ? "s" : "");
-				fflush(stdout);
 				return 0;
 			}
 			round++;
@@ -486,7 +483,6 @@ static int tcpm_do_cmd(int cmd, int argc, char **argv)
 			if (show_stats) {
 				printf("\n*** Round %d, deleting %d entries ***\n",
 				       round, f.flushed);
-				fflush(stdout);
 			}
 		}
 		return 0;
diff --git a/ip/xfrm_monitor.c b/ip/xfrm_monitor.c
index 1f67fe9d..a96358b0 100644
--- a/ip/xfrm_monitor.c
+++ b/ip/xfrm_monitor.c
@@ -85,7 +85,6 @@ static int xfrm_acquire_print(struct nlmsghdr *n, void *a=
rg)
=20
 	if (oneline)
 		fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
@@ -114,7 +113,6 @@ static int xfrm_state_flush_print(struct nlmsghdr *n, v=
oid *arg)
=20
 	if (oneline)
 		fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
@@ -151,7 +149,6 @@ static int xfrm_policy_flush_print(struct nlmsghdr *n, =
void *arg)
=20
 	if (oneline)
 		fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
@@ -232,7 +229,6 @@ static int xfrm_ae_print(struct nlmsghdr *n, void *arg)
 	xfrm_usersa_print(&id->sa_id, id->reqid, fp);
=20
 	fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
@@ -257,7 +253,6 @@ static int xfrm_mapping_print(struct nlmsghdr *n, void =
*arg)
 	xfrm_usersa_print(&map->id, map->reqid, fp);
=20
 	fprintf(fp, "\n");
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/ip/xfrm_policy.c b/ip/xfrm_policy.c
index 8687ced3..e60acd5b 100644
--- a/ip/xfrm_policy.c
+++ b/ip/xfrm_policy.c
@@ -565,7 +565,6 @@ int xfrm_policy_print(struct nlmsghdr *n, void *arg)
=20
 	if (oneline)
 		fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
@@ -1232,7 +1231,6 @@ int xfrm_policy_default_print(struct nlmsghdr *n, FIL=
E *fp)
 	fprintf(fp, " in:  %s\n", xfrm_policy_to_str(up->in));
 	fprintf(fp, " fwd: %s\n", xfrm_policy_to_str(up->fwd));
 	fprintf(fp, " out: %s\n", xfrm_policy_to_str(up->out));
-	fflush(fp);
=20
 	return 0;
 }
diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index 252a7a53..dcd08d59 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -1051,7 +1051,6 @@ static int __do_xfrm_state_print(struct nlmsghdr *n, =
void *arg, bool nokeys)
=20
 	if (oneline)
 		fprintf(fp, "\n");
-	fflush(fp);
=20
 	return 0;
 }
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 6b275a1f..7c74ebd3 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1275,6 +1275,8 @@ int rtnl_listen(struct rtnl_handle *rtnl,
 			}
=20
 			err =3D handler(&ctrl, h, jarg);
+			fflush(stdout);
+
 			if (err < 0)
 				return err;
=20
diff --git a/tc/tc_class.c b/tc/tc_class.c
index 6d707d8c..ea6d986a 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -380,7 +380,6 @@ int print_class(struct nlmsghdr *n, void *arg)
 		close_json_object();
 	}
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index 7db850bd..b1dcf1ba 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -374,7 +374,6 @@ int print_filter(struct nlmsghdr *n, void *arg)
=20
 	print_ext_msg(tb);
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 7eb9a31b..634d5f70 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -344,7 +344,6 @@ int print_qdisc(struct nlmsghdr *n, void *arg)
=20
 	print_ext_msg(tb);
 	close_json_object();
-	fflush(fp);
 	return 0;
 }
=20
--=20
2.53.0



