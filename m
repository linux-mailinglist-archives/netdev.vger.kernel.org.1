Return-Path: <netdev+bounces-60398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F9781F0E0
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F731F2233B
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A754644F;
	Wed, 27 Dec 2023 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uHgqZX75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522E4644B
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e82f502a4cso33156587b3.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703697936; x=1704302736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjR8n9E0uRSuxg6/28vC5qPunCqo42FDhlYCadBsWAc=;
        b=uHgqZX75ndz8AELyg+DvruYHazc7emPTqtLSv2TUIxjPnMMdotQ5oD+3XKVf7odzsn
         SNOBM88mOIXpo9Ufgd+7L9/sEDZnaTAbL/Jd27Ss8OWiSIL8zyt111WJSmS+l55ewj3W
         oghdGPRAQgXsnqGrM0GD25GnU8bFUZQD6CuhlcS6kcsgjWZj4NMkcusf5J9o6UnLzEbz
         9IDRmZjqoeeU0Ap8+l7V9Cne46vuds/gysWOqW/dBcJO3LlvhE9PpAuqlJ4yt9BYdu57
         CZM85rLvW2q/KM8trlbK7AhuJo0qzpCLPBBp43EdZ7ZAijsbNJNAb6cQciyYQSTqrjlP
         pYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703697936; x=1704302736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjR8n9E0uRSuxg6/28vC5qPunCqo42FDhlYCadBsWAc=;
        b=CoO+KVZdTb9z2KE6ZUYnGqBJhOUwJJVItqNPHsIw2kx4/qfifcduW9OAWPVuPVRB8f
         Kizv7O6vKUPcgVZBLjZdqzFaNclVcq0B/iEHtt8xiblzm/MlYiLVNMN5DRH5KuBmbGNt
         6YrBtK1PRENAE/d2Yo81rTDR1qRS8lGc0HI7tl1OULoCtSQ+m0709ODUG7bzdWBdYGN2
         cv4bLaRKmphsD0lYqmcnzSB7/dWGuKJ7aavpP0duYPDmyAVu7nNnHGRAkxDPBo4V4mi4
         y6266flODom4OInTbV+minbBI3d9q8o3zeseiKJDkLYWublUAQx6RgbHcpOAXojk7qgR
         euYQ==
X-Gm-Message-State: AOJu0Yy3C5honkfvaYSgN4HyQNtQ2msmwygoDNBbo/FOF56jEQDywoDJ
	NzpudN+t+IItBB+a4QubyQDZ919VBXhGYpiMqElq6XLWUR8iFjCaJcAgDUE=
X-Google-Smtp-Source: AGHT+IF2sJKbHKkEy9jUlubOjybBNWN1BedEc3YUvrDTOJb797As91LymiSuPdcXQKt2zSPEPKWdsNsx6Mh4Ijm8dSg=
X-Received: by 2002:a81:53d5:0:b0:5e7:ecff:a2d5 with SMTP id
 h204-20020a8153d5000000b005e7ecffa2d5mr3604558ywb.77.1703697935381; Wed, 27
 Dec 2023 09:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226182531.34717-1-stephen@networkplumber.org>
In-Reply-To: <20231226182531.34717-1-stephen@networkplumber.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 Dec 2023 12:25:24 -0500
Message-ID: <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 1:25=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> There is an open upstream kernel patch to remove ipt action from
> kernel. This is corresponding iproute2 change.
>
>  - Remove support fot ipt and xt in tc.
>  - Remove no longer used header files.
>  - Update man pages.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  configure                            |  34 --
>  include/ip6tables.h                  |  21 --
>  include/iptables.h                   |  26 --
>  include/iptables/internal.h          |  14 -
>  include/libiptc/ipt_kernel_headers.h |  16 -
>  include/libiptc/libip6tc.h           | 162 ---------
>  include/libiptc/libiptc.h            | 173 ---------
>  include/libiptc/libxtc.h             |  34 --
>  include/libiptc/xtcshared.h          |  21 --
>  man/man8/tc-xt.8                     |  42 ---
>  tc/Makefile                          |  12 -
>  tc/m_ipt.c                           | 511 ---------------------------
>  tc/m_xt.c                            | 400 ---------------------
>  tc/m_xt_old.c                        | 432 ----------------------

Does em_ipt need the m_xt*.c? Florian/Eyal can comment. Otherwise,
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal


>  14 files changed, 1898 deletions(-)
>  delete mode 100644 include/ip6tables.h
>  delete mode 100644 include/iptables.h
>  delete mode 100644 include/iptables/internal.h
>  delete mode 100644 include/libiptc/ipt_kernel_headers.h
>  delete mode 100644 include/libiptc/libip6tc.h
>  delete mode 100644 include/libiptc/libiptc.h
>  delete mode 100644 include/libiptc/libxtc.h
>  delete mode 100644 include/libiptc/xtcshared.h
>  delete mode 100644 man/man8/tc-xt.8
>  delete mode 100644 tc/m_ipt.c
>  delete mode 100644 tc/m_xt.c
>  delete mode 100644 tc/m_xt_old.c
>
> diff --git a/configure b/configure
> index 78bc52c008f8..722a6a06e675 100755
> --- a/configure
> +++ b/configure
> @@ -160,35 +160,6 @@ check_lib_dir()
>         echo "LIBDIR:=3D$LIBDIR" >> $CONFIG
>  }
>
> -check_ipt()
> -{
> -       if ! grep TC_CONFIG_XT $CONFIG > /dev/null; then
> -               echo "using iptables"
> -       fi
> -}
> -
> -check_ipt_lib_dir()
> -{
> -       IPT_LIB_DIR=3D$(${PKG_CONFIG} --variable=3Dxtlibdir xtables)
> -       if [ -n "$IPT_LIB_DIR" ]; then
> -               echo $IPT_LIB_DIR
> -               echo "IPT_LIB_DIR:=3D$IPT_LIB_DIR" >> $CONFIG
> -               return
> -       fi
> -
> -       for dir in /lib /usr/lib /usr/local/lib; do
> -               for file in "xtables" "iptables"; do
> -                       file=3D"$dir/$file/lib*t_*so"
> -                       if [ -f $file ]; then
> -                               echo ${file%/*}
> -                               echo "IPT_LIB_DIR:=3D${file%/*}" >> $CONF=
IG
> -                               return
> -                       fi
> -               done
> -       done
> -       echo "not found!"
> -}
> -
>  check_setns()
>  {
>      cat >$TMPDIR/setnstest.c <<EOF
> @@ -626,7 +597,6 @@ if ! grep -q TC_CONFIG_NO_XT $CONFIG; then
>         check_xt
>         check_xt_old
>         check_xt_old_internal_h
> -       check_ipt
>
>         echo -n " IPSET  "
>         check_ipset
> @@ -634,10 +604,6 @@ fi
>
>  echo
>  check_lib_dir
> -if ! grep -q TC_CONFIG_NO_XT $CONFIG; then
> -       echo -n "iptables modules directory: "
> -       check_ipt_lib_dir
> -fi
>
>  echo -n "libc has setns: "
>  check_setns
> diff --git a/include/ip6tables.h b/include/ip6tables.h
> deleted file mode 100644
> index bfb286826af5..000000000000
> --- a/include/ip6tables.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _IP6TABLES_USER_H
> -#define _IP6TABLES_USER_H
> -
> -#include <netinet/ip.h>
> -#include <xtables.h>
> -#include <libiptc/libip6tc.h>
> -#include <iptables/internal.h>
> -
> -/* Your shared library should call one of these. */
> -extern int do_command6(int argc, char *argv[], char **table,
> -                      struct xtc_handle **handle, bool restore);
> -
> -extern int for_each_chain6(int (*fn)(const xt_chainlabel, int, struct xt=
c_handle *), int verbose, int builtinstoo, struct xtc_handle *handle);
> -extern int flush_entries6(const xt_chainlabel chain, int verbose, struct=
 xtc_handle *handle);
> -extern int delete_chain6(const xt_chainlabel chain, int verbose, struct =
xtc_handle *handle);
> -void print_rule6(const struct ip6t_entry *e, struct xtc_handle *h, const=
 char *chain, int counters);
> -
> -extern struct xtables_globals ip6tables_globals;
> -
> -#endif /*_IP6TABLES_USER_H*/
> diff --git a/include/iptables.h b/include/iptables.h
> deleted file mode 100644
> index eb91f2918658..000000000000
> --- a/include/iptables.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _IPTABLES_USER_H
> -#define _IPTABLES_USER_H
> -
> -#include <netinet/ip.h>
> -#include <xtables.h>
> -#include <libiptc/libiptc.h>
> -#include <iptables/internal.h>
> -
> -/* Your shared library should call one of these. */
> -extern int do_command4(int argc, char *argv[], char **table,
> -                     struct xtc_handle **handle, bool restore);
> -extern int delete_chain4(const xt_chainlabel chain, int verbose,
> -                       struct xtc_handle *handle);
> -extern int flush_entries4(const xt_chainlabel chain, int verbose,
> -                       struct xtc_handle *handle);
> -extern int for_each_chain4(int (*fn)(const xt_chainlabel, int, struct xt=
c_handle *),
> -               int verbose, int builtinstoo, struct xtc_handle *handle);
> -extern void print_rule4(const struct ipt_entry *e,
> -               struct xtc_handle *handle, const char *chain, int counter=
s);
> -
> -extern struct xtables_globals iptables_globals;
> -
> -extern struct xtables_globals xtables_globals;
> -
> -#endif /*_IPTABLES_USER_H*/
> diff --git a/include/iptables/internal.h b/include/iptables/internal.h
> deleted file mode 100644
> index 1fd137250031..000000000000
> --- a/include/iptables/internal.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef IPTABLES_INTERNAL_H
> -#define IPTABLES_INTERNAL_H 1
> -
> -#define IPTABLES_VERSION "1.6.0"
> -
> -/**
> - * Program's own name and version.
> - */
> -extern const char *program_name, *program_version;
> -
> -extern int line;
> -
> -#endif /* IPTABLES_INTERNAL_H */
> diff --git a/include/libiptc/ipt_kernel_headers.h b/include/libiptc/ipt_k=
ernel_headers.h
> deleted file mode 100644
> index 3d2a2a3277e9..000000000000
> --- a/include/libiptc/ipt_kernel_headers.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* This is the userspace/kernel interface for Generic IP Chains,
> -   required for libc6. */
> -#ifndef _FWCHAINS_KERNEL_HEADERS_H
> -#define _FWCHAINS_KERNEL_HEADERS_H
> -
> -#include <limits.h>
> -
> -#include <netinet/ip.h>
> -#include <netinet/in.h>
> -#include <netinet/ip_icmp.h>
> -#include <netinet/tcp.h>
> -#include <netinet/udp.h>
> -#include <net/if.h>
> -#include <sys/types.h>
> -#endif
> diff --git a/include/libiptc/libip6tc.h b/include/libiptc/libip6tc.h
> deleted file mode 100644
> index cd588de7a96d..000000000000
> --- a/include/libiptc/libip6tc.h
> +++ /dev/null
> @@ -1,162 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LIBIP6TC_H
> -#define _LIBIP6TC_H
> -/* Library which manipulates firewall rules. Version 0.2. */
> -
> -#include <linux/types.h>
> -#include <libiptc/ipt_kernel_headers.h>
> -#ifdef __cplusplus
> -#      include <climits>
> -#else
> -#      include <limits.h> /* INT_MAX in ip6_tables.h */
> -#endif
> -#include <linux/netfilter_ipv6/ip6_tables.h>
> -#include <libiptc/xtcshared.h>
> -
> -#define ip6tc_handle xtc_handle
> -#define ip6t_chainlabel xt_chainlabel
> -
> -#define IP6TC_LABEL_ACCEPT "ACCEPT"
> -#define IP6TC_LABEL_DROP "DROP"
> -#define IP6TC_LABEL_QUEUE   "QUEUE"
> -#define IP6TC_LABEL_RETURN "RETURN"
> -
> -/* Does this chain exist? */
> -int ip6tc_is_chain(const char *chain, struct xtc_handle *const handle);
> -
> -/* Take a snapshot of the rules. Returns NULL on error. */
> -struct xtc_handle *ip6tc_init(const char *tablename);
> -
> -/* Cleanup after ip6tc_init(). */
> -void ip6tc_free(struct xtc_handle *h);
> -
> -/* Iterator functions to run through the chains.  Returns NULL at end. *=
/
> -const char *ip6tc_first_chain(struct xtc_handle *handle);
> -const char *ip6tc_next_chain(struct xtc_handle *handle);
> -
> -/* Get first rule in the given chain: NULL for empty chain. */
> -const struct ip6t_entry *ip6tc_first_rule(const char *chain,
> -                                         struct xtc_handle *handle);
> -
> -/* Returns NULL when rules run out. */
> -const struct ip6t_entry *ip6tc_next_rule(const struct ip6t_entry *prev,
> -                                        struct xtc_handle *handle);
> -
> -/* Returns a pointer to the target name of this position. */
> -const char *ip6tc_get_target(const struct ip6t_entry *e,
> -                            struct xtc_handle *handle);
> -
> -/* Is this a built-in chain? */
> -int ip6tc_builtin(const char *chain, struct xtc_handle *const handle);
> -
> -/* Get the policy of a given built-in chain */
> -const char *ip6tc_get_policy(const char *chain,
> -                            struct xt_counters *counters,
> -                            struct xtc_handle *handle);
> -
> -/* These functions return TRUE for OK or 0 and set errno. If errno =3D=
=3D
> -   0, it means there was a version error (ie. upgrade libiptc). */
> -/* Rule numbers start at 1 for the first rule. */
> -
> -/* Insert the entry `fw' in chain `chain' into position `rulenum'. */
> -int ip6tc_insert_entry(const xt_chainlabel chain,
> -                      const struct ip6t_entry *e,
> -                      unsigned int rulenum,
> -                      struct xtc_handle *handle);
> -
> -/* Atomically replace rule `rulenum' in `chain' with `fw'. */
> -int ip6tc_replace_entry(const xt_chainlabel chain,
> -                       const struct ip6t_entry *e,
> -                       unsigned int rulenum,
> -                       struct xtc_handle *handle);
> -
> -/* Append entry `fw' to chain `chain'. Equivalent to insert with
> -   rulenum =3D length of chain. */
> -int ip6tc_append_entry(const xt_chainlabel chain,
> -                      const struct ip6t_entry *e,
> -                      struct xtc_handle *handle);
> -
> -/* Check whether a matching rule exists */
> -int ip6tc_check_entry(const xt_chainlabel chain,
> -                      const struct ip6t_entry *origfw,
> -                      unsigned char *matchmask,
> -                      struct xtc_handle *handle);
> -
> -/* Delete the first rule in `chain' which matches `fw'. */
> -int ip6tc_delete_entry(const xt_chainlabel chain,
> -                      const struct ip6t_entry *origfw,
> -                      unsigned char *matchmask,
> -                      struct xtc_handle *handle);
> -
> -/* Delete the rule in position `rulenum' in `chain'. */
> -int ip6tc_delete_num_entry(const xt_chainlabel chain,
> -                          unsigned int rulenum,
> -                          struct xtc_handle *handle);
> -
> -/* Check the packet `fw' on chain `chain'. Returns the verdict, or
> -   NULL and sets errno. */
> -const char *ip6tc_check_packet(const xt_chainlabel chain,
> -                              struct ip6t_entry *,
> -                              struct xtc_handle *handle);
> -
> -/* Flushes the entries in the given chain (ie. empties chain). */
> -int ip6tc_flush_entries(const xt_chainlabel chain,
> -                       struct xtc_handle *handle);
> -
> -/* Zeroes the counters in a chain. */
> -int ip6tc_zero_entries(const xt_chainlabel chain,
> -                      struct xtc_handle *handle);
> -
> -/* Creates a new chain. */
> -int ip6tc_create_chain(const xt_chainlabel chain,
> -                      struct xtc_handle *handle);
> -
> -/* Deletes a chain. */
> -int ip6tc_delete_chain(const xt_chainlabel chain,
> -                      struct xtc_handle *handle);
> -
> -/* Renames a chain. */
> -int ip6tc_rename_chain(const xt_chainlabel oldname,
> -                      const xt_chainlabel newname,
> -                      struct xtc_handle *handle);
> -
> -/* Sets the policy on a built-in chain. */
> -int ip6tc_set_policy(const xt_chainlabel chain,
> -                    const xt_chainlabel policy,
> -                    struct xt_counters *counters,
> -                    struct xtc_handle *handle);
> -
> -/* Get the number of references to this chain */
> -int ip6tc_get_references(unsigned int *ref, const xt_chainlabel chain,
> -                        struct xtc_handle *handle);
> -
> -/* read packet and byte counters for a specific rule */
> -struct xt_counters *ip6tc_read_counter(const xt_chainlabel chain,
> -                                       unsigned int rulenum,
> -                                       struct xtc_handle *handle);
> -
> -/* zero packet and byte counters for a specific rule */
> -int ip6tc_zero_counter(const xt_chainlabel chain,
> -                      unsigned int rulenum,
> -                      struct xtc_handle *handle);
> -
> -/* set packet and byte counters for a specific rule */
> -int ip6tc_set_counter(const xt_chainlabel chain,
> -                     unsigned int rulenum,
> -                     struct xt_counters *counters,
> -                     struct xtc_handle *handle);
> -
> -/* Makes the actual changes. */
> -int ip6tc_commit(struct xtc_handle *handle);
> -
> -/* Get raw socket. */
> -int ip6tc_get_raw_socket(void);
> -
> -/* Translates errno numbers into more human-readable form than strerror.=
 */
> -const char *ip6tc_strerror(int err);
> -
> -extern void dump_entries6(struct xtc_handle *const);
> -
> -extern const struct xtc_ops ip6tc_ops;
> -
> -#endif /* _LIBIP6TC_H */
> diff --git a/include/libiptc/libiptc.h b/include/libiptc/libiptc.h
> deleted file mode 100644
> index 1bfe4e18e73e..000000000000
> --- a/include/libiptc/libiptc.h
> +++ /dev/null
> @@ -1,173 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LIBIPTC_H
> -#define _LIBIPTC_H
> -/* Library which manipulates filtering rules. */
> -
> -#include <linux/types.h>
> -#include <libiptc/ipt_kernel_headers.h>
> -#ifdef __cplusplus
> -#      include <climits>
> -#else
> -#      include <limits.h> /* INT_MAX in ip_tables.h */
> -#endif
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -#include <libiptc/xtcshared.h>
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -#define iptc_handle xtc_handle
> -#define ipt_chainlabel xt_chainlabel
> -
> -#define IPTC_LABEL_ACCEPT  "ACCEPT"
> -#define IPTC_LABEL_DROP    "DROP"
> -#define IPTC_LABEL_QUEUE   "QUEUE"
> -#define IPTC_LABEL_RETURN  "RETURN"
> -
> -/* Does this chain exist? */
> -int iptc_is_chain(const char *chain, struct xtc_handle *const handle);
> -
> -/* Take a snapshot of the rules.  Returns NULL on error. */
> -struct xtc_handle *iptc_init(const char *tablename);
> -
> -/* Cleanup after iptc_init(). */
> -void iptc_free(struct xtc_handle *h);
> -
> -/* Iterator functions to run through the chains.  Returns NULL at end. *=
/
> -const char *iptc_first_chain(struct xtc_handle *handle);
> -const char *iptc_next_chain(struct xtc_handle *handle);
> -
> -/* Get first rule in the given chain: NULL for empty chain. */
> -const struct ipt_entry *iptc_first_rule(const char *chain,
> -                                       struct xtc_handle *handle);
> -
> -/* Returns NULL when rules run out. */
> -const struct ipt_entry *iptc_next_rule(const struct ipt_entry *prev,
> -                                      struct xtc_handle *handle);
> -
> -/* Returns a pointer to the target name of this entry. */
> -const char *iptc_get_target(const struct ipt_entry *e,
> -                           struct xtc_handle *handle);
> -
> -/* Is this a built-in chain? */
> -int iptc_builtin(const char *chain, struct xtc_handle *const handle);
> -
> -/* Get the policy of a given built-in chain */
> -const char *iptc_get_policy(const char *chain,
> -                           struct xt_counters *counter,
> -                           struct xtc_handle *handle);
> -
> -/* These functions return TRUE for OK or 0 and set errno.  If errno =3D=
=3D
> -   0, it means there was a version error (ie. upgrade libiptc). */
> -/* Rule numbers start at 1 for the first rule. */
> -
> -/* Insert the entry `e' in chain `chain' into position `rulenum'. */
> -int iptc_insert_entry(const xt_chainlabel chain,
> -                     const struct ipt_entry *e,
> -                     unsigned int rulenum,
> -                     struct xtc_handle *handle);
> -
> -/* Atomically replace rule `rulenum' in `chain' with `e'. */
> -int iptc_replace_entry(const xt_chainlabel chain,
> -                      const struct ipt_entry *e,
> -                      unsigned int rulenum,
> -                      struct xtc_handle *handle);
> -
> -/* Append entry `e' to chain `chain'.  Equivalent to insert with
> -   rulenum =3D length of chain. */
> -int iptc_append_entry(const xt_chainlabel chain,
> -                     const struct ipt_entry *e,
> -                     struct xtc_handle *handle);
> -
> -/* Check whether a mathching rule exists */
> -int iptc_check_entry(const xt_chainlabel chain,
> -                     const struct ipt_entry *origfw,
> -                     unsigned char *matchmask,
> -                     struct xtc_handle *handle);
> -
> -/* Delete the first rule in `chain' which matches `e', subject to
> -   matchmask (array of length =3D=3D origfw) */
> -int iptc_delete_entry(const xt_chainlabel chain,
> -                     const struct ipt_entry *origfw,
> -                     unsigned char *matchmask,
> -                     struct xtc_handle *handle);
> -
> -/* Delete the rule in position `rulenum' in `chain'. */
> -int iptc_delete_num_entry(const xt_chainlabel chain,
> -                         unsigned int rulenum,
> -                         struct xtc_handle *handle);
> -
> -/* Check the packet `e' on chain `chain'.  Returns the verdict, or
> -   NULL and sets errno. */
> -const char *iptc_check_packet(const xt_chainlabel chain,
> -                             struct ipt_entry *entry,
> -                             struct xtc_handle *handle);
> -
> -/* Flushes the entries in the given chain (ie. empties chain). */
> -int iptc_flush_entries(const xt_chainlabel chain,
> -                      struct xtc_handle *handle);
> -
> -/* Zeroes the counters in a chain. */
> -int iptc_zero_entries(const xt_chainlabel chain,
> -                     struct xtc_handle *handle);
> -
> -/* Creates a new chain. */
> -int iptc_create_chain(const xt_chainlabel chain,
> -                     struct xtc_handle *handle);
> -
> -/* Deletes a chain. */
> -int iptc_delete_chain(const xt_chainlabel chain,
> -                     struct xtc_handle *handle);
> -
> -/* Renames a chain. */
> -int iptc_rename_chain(const xt_chainlabel oldname,
> -                     const xt_chainlabel newname,
> -                     struct xtc_handle *handle);
> -
> -/* Sets the policy on a built-in chain. */
> -int iptc_set_policy(const xt_chainlabel chain,
> -                   const xt_chainlabel policy,
> -                   struct xt_counters *counters,
> -                   struct xtc_handle *handle);
> -
> -/* Get the number of references to this chain */
> -int iptc_get_references(unsigned int *ref,
> -                       const xt_chainlabel chain,
> -                       struct xtc_handle *handle);
> -
> -/* read packet and byte counters for a specific rule */
> -struct xt_counters *iptc_read_counter(const xt_chainlabel chain,
> -                                      unsigned int rulenum,
> -                                      struct xtc_handle *handle);
> -
> -/* zero packet and byte counters for a specific rule */
> -int iptc_zero_counter(const xt_chainlabel chain,
> -                     unsigned int rulenum,
> -                     struct xtc_handle *handle);
> -
> -/* set packet and byte counters for a specific rule */
> -int iptc_set_counter(const xt_chainlabel chain,
> -                    unsigned int rulenum,
> -                    struct xt_counters *counters,
> -                    struct xtc_handle *handle);
> -
> -/* Makes the actual changes. */
> -int iptc_commit(struct xtc_handle *handle);
> -
> -/* Get raw socket. */
> -int iptc_get_raw_socket(void);
> -
> -/* Translates errno numbers into more human-readable form than strerror.=
 */
> -const char *iptc_strerror(int err);
> -
> -extern void dump_entries(struct xtc_handle *const);
> -
> -extern const struct xtc_ops iptc_ops;
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -
> -
> -#endif /* _LIBIPTC_H */
> diff --git a/include/libiptc/libxtc.h b/include/libiptc/libxtc.h
> deleted file mode 100644
> index 1e9596a6e01c..000000000000
> --- a/include/libiptc/libxtc.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LIBXTC_H
> -#define _LIBXTC_H
> -/* Library which manipulates filtering rules. */
> -
> -#include <libiptc/ipt_kernel_headers.h>
> -#include <linux/netfilter/x_tables.h>
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -#ifndef XT_MIN_ALIGN
> -/* xt_entry has pointers and u_int64_t's in it, so if you align to
> -   it, you'll also align to any crazy matches and targets someone
> -   might write */
> -#define XT_MIN_ALIGN (__alignof__(struct xt_entry))
> -#endif
> -
> -#ifndef XT_ALIGN
> -#define XT_ALIGN(s) (((s) + ((XT_MIN_ALIGN)-1)) & ~((XT_MIN_ALIGN)-1))
> -#endif
> -
> -#define XTC_LABEL_ACCEPT  "ACCEPT"
> -#define XTC_LABEL_DROP    "DROP"
> -#define XTC_LABEL_QUEUE   "QUEUE"
> -#define XTC_LABEL_RETURN  "RETURN"
> -
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -
> -#endif /* _LIBXTC_H */
> diff --git a/include/libiptc/xtcshared.h b/include/libiptc/xtcshared.h
> deleted file mode 100644
> index 278a58f4eb9f..000000000000
> --- a/include/libiptc/xtcshared.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LIBXTC_SHARED_H
> -#define _LIBXTC_SHARED_H 1
> -
> -typedef char xt_chainlabel[32];
> -struct xtc_handle;
> -struct xt_counters;
> -
> -struct xtc_ops {
> -       int (*commit)(struct xtc_handle *);
> -       void (*free)(struct xtc_handle *);
> -       int (*builtin)(const char *, struct xtc_handle *const);
> -       int (*is_chain)(const char *, struct xtc_handle *const);
> -       int (*flush_entries)(const xt_chainlabel, struct xtc_handle *);
> -       int (*create_chain)(const xt_chainlabel, struct xtc_handle *);
> -       int (*set_policy)(const xt_chainlabel, const xt_chainlabel,
> -                         struct xt_counters *, struct xtc_handle *);
> -       const char *(*strerror)(int);
> -};
> -
> -#endif /* _LIBXTC_SHARED_H */
> diff --git a/man/man8/tc-xt.8 b/man/man8/tc-xt.8
> deleted file mode 100644
> index f6dc5addf254..000000000000
> --- a/man/man8/tc-xt.8
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -.TH "iptables action in tc" 8 "3 Mar 2016" "iproute2" "Linux"
> -
> -.SH NAME
> -xt - tc iptables action
> -.SH SYNOPSIS
> -.in +8
> -.ti -8
> -.BR tc " ... " "action xt \-j"
> -.IR TARGET " [ " TARGET_OPTS " ]"
> -.SH DESCRIPTION
> -The
> -.B xt
> -action allows one to call arbitrary iptables targets for packets matchin=
g the filter
> -this action is attached to.
> -.SH OPTIONS
> -.TP
> -.BI -j " TARGET \fR[\fI TARGET_OPTS \fR]"
> -Perform a jump to the given iptables target, optionally passing any targ=
et
> -specific options in
> -.IR TARGET_OPTS .
> -.SH EXAMPLES
> -The following will attach a
> -.B u32
> -filter to the
> -.B ingress
> -qdisc matching ICMP replies and using the
> -.B xt
> -action to make the kernel yell 'PONG' each time:
> -
> -.RS
> -.EX
> -tc qdisc add dev eth0 ingress
> -tc filter add dev eth0 parent ffff: proto ip u32 \\
> -       match ip protocol 1 0xff \\
> -       match ip icmp_type 0 0xff \\
> -       action xt -j LOG --log-prefix PONG
> -.EE
> -.RE
> -.SH SEE ALSO
> -.BR tc (8),
> -.BR tc-u32 (8),
> -.BR iptables-extensions (8)
> diff --git a/tc/Makefile b/tc/Makefile
> index 9cb0d0edde93..b5e853d8c56b 100644
> --- a/tc/Makefile
> +++ b/tc/Makefile
> @@ -82,22 +82,10 @@ TCSO :=3D
>
>  ifneq ($(TC_CONFIG_NO_XT),y)
>    ifeq ($(TC_CONFIG_XT),y)
> -    TCSO +=3D m_xt.so
>      TCMODULES +=3D em_ipt.o
>      ifeq ($(TC_CONFIG_IPSET),y)
>        TCMODULES +=3D em_ipset.o
>      endif
> -  else
> -    ifeq ($(TC_CONFIG_XT_OLD),y)
> -      TCSO +=3D m_xt_old.so
> -    else
> -      ifeq ($(TC_CONFIG_XT_OLD_H),y)
> -        CFLAGS +=3D -DTC_CONFIG_XT_H
> -        TCSO +=3D m_xt_old.so
> -      else
> -        TCMODULES +=3D m_ipt.o
> -      endif
> -    endif
>    endif
>  endif
>
> diff --git a/tc/m_ipt.c b/tc/m_ipt.c
> deleted file mode 100644
> index 2538f769b0ee..000000000000
> --- a/tc/m_ipt.c
> +++ /dev/null
> @@ -1,511 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * m_ipt.c     iptables based targets
> - *             utilities mostly ripped from iptables <duh, its the linux=
 way>
> - *
> - * Authors:  J Hadi Salim (hadi@cyberus.ca)
> - */
> -
> -#include <sys/socket.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <iptables.h>
> -#include <linux/netfilter.h>
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -#include "utils.h"
> -#include "tc_util.h"
> -#include <linux/tc_act/tc_ipt.h>
> -#include <stdio.h>
> -#include <dlfcn.h>
> -#include <getopt.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <netdb.h>
> -#include <stdlib.h>
> -#include <ctype.h>
> -#include <stdarg.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/wait.h>
> -
> -static const char *pname =3D "tc-ipt";
> -static const char *tname =3D "mangle";
> -static const char *pversion =3D "0.1";
> -
> -static const char *ipthooks[] =3D {
> -       "NF_IP_PRE_ROUTING",
> -       "NF_IP_LOCAL_IN",
> -       "NF_IP_FORWARD",
> -       "NF_IP_LOCAL_OUT",
> -       "NF_IP_POST_ROUTING",
> -};
> -
> -static struct option original_opts[] =3D {
> -       {"jump", 1, 0, 'j'},
> -       {0, 0, 0, 0}
> -};
> -
> -static struct xtables_target *t_list;
> -static struct option *opts =3D original_opts;
> -static unsigned int global_option_offset;
> -#define OPTION_OFFSET 256
> -
> -char *lib_dir;
> -
> -void
> -xtables_register_target(struct xtables_target *me)
> -{
> -       me->next =3D t_list;
> -       t_list =3D me;
> -
> -}
> -
> -static void exit_tryhelp(int status)
> -{
> -       fprintf(stderr, "Try `%s -h' or '%s --help' for more information.=
\n",
> -               pname, pname);
> -       exit(status);
> -}
> -
> -static void exit_error(enum xtables_exittype status, char *msg, ...)
> -{
> -       va_list args;
> -
> -       va_start(args, msg);
> -       fprintf(stderr, "%s v%s: ", pname, pversion);
> -       vfprintf(stderr, msg, args);
> -       va_end(args);
> -       fprintf(stderr, "\n");
> -       if (status =3D=3D PARAMETER_PROBLEM)
> -               exit_tryhelp(status);
> -       if (status =3D=3D VERSION_PROBLEM)
> -               fprintf(stderr,
> -                       "Perhaps iptables or your kernel needs to be upgr=
aded.\n");
> -       exit(status);
> -}
> -
> -/* stolen from iptables 1.2.11
> -They should really have them as a library so i can link to them
> -Email them next time i remember
> -*/
> -
> -static void free_opts(struct option *local_opts)
> -{
> -       if (local_opts !=3D original_opts) {
> -               free(local_opts);
> -               opts =3D original_opts;
> -               global_option_offset =3D 0;
> -       }
> -}
> -
> -static struct option *
> -merge_options(struct option *oldopts, const struct option *newopts,
> -             unsigned int *option_offset)
> -{
> -       struct option *merge;
> -       unsigned int num_old, num_new, i;
> -
> -       for (num_old =3D 0; oldopts[num_old].name; num_old++);
> -       for (num_new =3D 0; newopts[num_new].name; num_new++);
> -
> -       *option_offset =3D global_option_offset + OPTION_OFFSET;
> -
> -       merge =3D malloc(sizeof(struct option) * (num_new + num_old + 1))=
;
> -       memcpy(merge, oldopts, num_old * sizeof(struct option));
> -       for (i =3D 0; i < num_new; i++) {
> -               merge[num_old + i] =3D newopts[i];
> -               merge[num_old + i].val +=3D *option_offset;
> -       }
> -       memset(merge + num_old + num_new, 0, sizeof(struct option));
> -
> -       return merge;
> -}
> -
> -static void *
> -fw_calloc(size_t count, size_t size)
> -{
> -       void *p;
> -
> -       if ((p =3D (void *) calloc(count, size)) =3D=3D NULL) {
> -               perror("iptables: calloc failed");
> -               exit(1);
> -       }
> -       return p;
> -}
> -
> -static struct xtables_target *
> -find_t(char *name)
> -{
> -       struct xtables_target *m;
> -
> -       for (m =3D t_list; m; m =3D m->next) {
> -               if (strcmp(m->name, name) =3D=3D 0)
> -                       return m;
> -       }
> -
> -       return NULL;
> -}
> -
> -static struct xtables_target *
> -get_target_name(const char *name)
> -{
> -       void *handle;
> -       char *error;
> -       char *new_name, *lname;
> -       struct xtables_target *m;
> -       char path[strlen(lib_dir) + sizeof("/libipt_.so") + strlen(name)]=
;
> -
> -#ifdef NO_SHARED_LIBS
> -       return NULL;
> -#endif
> -
> -       new_name =3D calloc(1, strlen(name) + 1);
> -       lname =3D calloc(1, strlen(name) + 1);
> -       if (!new_name)
> -               exit_error(PARAMETER_PROBLEM, "get_target_name");
> -       if (!lname)
> -               exit_error(PARAMETER_PROBLEM, "get_target_name");
> -
> -       strcpy(new_name, name);
> -       strcpy(lname, name);
> -
> -       if (isupper(lname[0])) {
> -               int i;
> -
> -               for (i =3D 0; i < strlen(name); i++) {
> -                       lname[i] =3D tolower(lname[i]);
> -               }
> -       }
> -
> -       if (islower(new_name[0])) {
> -               int i;
> -
> -               for (i =3D 0; i < strlen(new_name); i++) {
> -                       new_name[i] =3D toupper(new_name[i]);
> -               }
> -       }
> -
> -       /* try libxt_xx first */
> -       sprintf(path, "%s/libxt_%s.so", lib_dir, new_name);
> -       handle =3D dlopen(path, RTLD_LAZY);
> -       if (!handle) {
> -               /* try libipt_xx next */
> -               sprintf(path, "%s/libipt_%s.so", lib_dir, new_name);
> -               handle =3D dlopen(path, RTLD_LAZY);
> -
> -               if (!handle) {
> -                       sprintf(path, "%s/libxt_%s.so", lib_dir, lname);
> -                       handle =3D dlopen(path, RTLD_LAZY);
> -               }
> -
> -               if (!handle) {
> -                       sprintf(path, "%s/libipt_%s.so", lib_dir, lname);
> -                       handle =3D dlopen(path, RTLD_LAZY);
> -               }
> -               /* ok, lets give up .. */
> -               if (!handle) {
> -                       fputs(dlerror(), stderr);
> -                       printf("\n");
> -                       free(new_name);
> -                       free(lname);
> -                       return NULL;
> -               }
> -       }
> -
> -       m =3D dlsym(handle, new_name);
> -       if ((error =3D dlerror()) !=3D NULL) {
> -               m =3D (struct xtables_target *) dlsym(handle, lname);
> -               if ((error =3D dlerror()) !=3D NULL) {
> -                       m =3D find_t(new_name);
> -                       if (m =3D=3D NULL) {
> -                               m =3D find_t(lname);
> -                               if (m =3D=3D NULL) {
> -                                       fputs(error, stderr);
> -                                       fprintf(stderr, "\n");
> -                                       dlclose(handle);
> -                                       free(new_name);
> -                                       free(lname);
> -                                       return NULL;
> -                               }
> -                       }
> -               }
> -       }
> -
> -       free(new_name);
> -       free(lname);
> -       return m;
> -}
> -
> -static void set_revision(char *name, u_int8_t revision)
> -{
> -       /* Old kernel sources don't have ".revision" field,
> -       *  but we stole a byte from name. */
> -       name[IPT_FUNCTION_MAXNAMELEN - 2] =3D '\0';
> -       name[IPT_FUNCTION_MAXNAMELEN - 1] =3D revision;
> -}
> -
> -/*
> - * we may need to check for version mismatch
> -*/
> -static int build_st(struct xtables_target *target, struct ipt_entry_targ=
et *t)
> -{
> -       if (target) {
> -               size_t size;
> -
> -               size =3D
> -                   XT_ALIGN(sizeof(struct ipt_entry_target)) + target->s=
ize;
> -
> -               if (t =3D=3D NULL) {
> -                       target->t =3D fw_calloc(1, size);
> -                       target->t->u.target_size =3D size;
> -
> -                       if (target->init !=3D NULL)
> -                               target->init(target->t);
> -                       set_revision(target->t->u.user.name, target->revi=
sion);
> -               } else {
> -                       target->t =3D t;
> -               }
> -               strcpy(target->t->u.user.name, target->name);
> -               return 0;
> -       }
> -
> -       return -1;
> -}
> -
> -static int parse_ipt(struct action_util *a, int *argc_p,
> -                    char ***argv_p, int tca_id, struct nlmsghdr *n)
> -{
> -       struct xtables_target *m =3D NULL;
> -       struct ipt_entry fw;
> -       struct rtattr *tail;
> -       int c;
> -       int rargc =3D *argc_p;
> -       char **argv =3D *argv_p;
> -       int argc =3D 0, iargc =3D 0;
> -       char k[FILTER_NAMESZ];
> -       int size =3D 0;
> -       int iok =3D 0, ok =3D 0;
> -       __u32 hook =3D 0, index =3D 0;
> -
> -       lib_dir =3D getenv("IPTABLES_LIB_DIR");
> -       if (!lib_dir)
> -               lib_dir =3D IPT_LIB_DIR;
> -
> -       {
> -               int i;
> -
> -               for (i =3D 0; i < rargc; i++) {
> -                       if (!argv[i] || strcmp(argv[i], "action") =3D=3D =
0)
> -                               break;
> -               }
> -               iargc =3D argc =3D i;
> -       }
> -
> -       if (argc <=3D 2) {
> -               fprintf(stderr, "bad arguments to ipt %d vs %d\n", argc, =
rargc);
> -               return -1;
> -       }
> -
> -       while (1) {
> -               c =3D getopt_long(argc, argv, "j:", opts, NULL);
> -               if (c =3D=3D -1)
> -                       break;
> -               switch (c) {
> -               case 'j':
> -                       m =3D get_target_name(optarg);
> -                       if (m !=3D NULL) {
> -
> -                               if (build_st(m, NULL) < 0) {
> -                                       printf(" %s error\n", m->name);
> -                                       return -1;
> -                               }
> -                               opts =3D
> -                                   merge_options(opts, m->extra_opts,
> -                                                 &m->option_offset);
> -                       } else {
> -                               fprintf(stderr, " failed to find target %=
s\n\n", optarg);
> -                               return -1;
> -                       }
> -                       ok++;
> -                       break;
> -
> -               default:
> -                       memset(&fw, 0, sizeof(fw));
> -                       if (m) {
> -                               m->parse(c - m->option_offset, argv, 0,
> -                                        &m->tflags, NULL, &m->t);
> -                       } else {
> -                               fprintf(stderr, " failed to find target %=
s\n\n", optarg);
> -                               return -1;
> -
> -                       }
> -                       ok++;
> -                       break;
> -
> -               }
> -       }
> -
> -       if (iargc > optind) {
> -               if (matches(argv[optind], "index") =3D=3D 0) {
> -                       if (get_u32(&index, argv[optind + 1], 10)) {
> -                               fprintf(stderr, "Illegal \"index\"\n");
> -                               free_opts(opts);
> -                               return -1;
> -                       }
> -                       iok++;
> -
> -                       optind +=3D 2;
> -               }
> -       }
> -
> -       if (!ok && !iok) {
> -               fprintf(stderr, " ipt Parser BAD!! (%s)\n", *argv);
> -               return -1;
> -       }
> -
> -       /* check that we passed the correct parameters to the target */
> -       if (m)
> -               m->final_check(m->tflags);
> -
> -       {
> -               struct tcmsg *t =3D NLMSG_DATA(n);
> -
> -               if (t->tcm_parent !=3D TC_H_ROOT
> -                   && t->tcm_parent =3D=3D TC_H_MAJ(TC_H_INGRESS)) {
> -                       hook =3D NF_IP_PRE_ROUTING;
> -               } else {
> -                       hook =3D NF_IP_POST_ROUTING;
> -               }
> -       }
> -
> -       tail =3D addattr_nest(n, MAX_MSG, tca_id);
> -       fprintf(stdout, "tablename: %s hook: %s\n ", tname, ipthooks[hook=
]);
> -       fprintf(stdout, "\ttarget: ");
> -
> -       if (m)
> -               m->print(NULL, m->t, 0);
> -       fprintf(stdout, " index %d\n", index);
> -
> -       if (strlen(tname) > 16) {
> -               size =3D 16;
> -               k[15] =3D 0;
> -       } else {
> -               size =3D 1 + strlen(tname);
> -       }
> -       strncpy(k, tname, size);
> -
> -       addattr_l(n, MAX_MSG, TCA_IPT_TABLE, k, size);
> -       addattr_l(n, MAX_MSG, TCA_IPT_HOOK, &hook, 4);
> -       addattr_l(n, MAX_MSG, TCA_IPT_INDEX, &index, 4);
> -       if (m)
> -               addattr_l(n, MAX_MSG, TCA_IPT_TARG, m->t, m->t->u.target_=
size);
> -       addattr_nest_end(n, tail);
> -
> -       argc -=3D optind;
> -       argv +=3D optind;
> -       *argc_p =3D rargc - iargc;
> -       *argv_p =3D argv;
> -
> -       optind =3D 0;
> -       free_opts(opts);
> -       /* Clear flags if target will be used again */
> -       m->tflags =3D 0;
> -       m->used =3D 0;
> -       /* Free allocated memory */
> -       free(m->t);
> -
> -
> -       return 0;
> -
> -}
> -
> -static int
> -print_ipt(struct action_util *au, FILE * f, struct rtattr *arg)
> -{
> -       struct rtattr *tb[TCA_IPT_MAX + 1];
> -       struct ipt_entry_target *t =3D NULL;
> -       struct xtables_target *m;
> -       __u32 hook;
> -
> -       if (arg =3D=3D NULL)
> -               return 0;
> -
> -       lib_dir =3D getenv("IPTABLES_LIB_DIR");
> -       if (!lib_dir)
> -               lib_dir =3D IPT_LIB_DIR;
> -
> -       parse_rtattr_nested(tb, TCA_IPT_MAX, arg);
> -
> -       if (tb[TCA_IPT_TABLE] =3D=3D NULL) {
> -               fprintf(stderr,  "Missing ipt table name, assuming mangle=
\n");
> -       } else {
> -               fprintf(f, "tablename: %s ",
> -                       rta_getattr_str(tb[TCA_IPT_TABLE]));
> -       }
> -
> -       if (tb[TCA_IPT_HOOK] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt hook name\n ");
> -               return -1;
> -       }
> -
> -       hook =3D rta_getattr_u32(tb[TCA_IPT_HOOK]);
> -       fprintf(f, " hook: %s\n", ipthooks[hook]);
> -
> -       if (tb[TCA_IPT_TARG] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt target parameters\n");
> -               return -1;
> -       }
> -
> -
> -       t =3D RTA_DATA(tb[TCA_IPT_TARG]);
> -       m =3D get_target_name(t->u.user.name);
> -       if (m !=3D NULL) {
> -               if (build_st(m, t) < 0) {
> -                       fprintf(stderr, " %s error\n", m->name);
> -                       return -1;
> -               }
> -
> -               opts =3D
> -                       merge_options(opts, m->extra_opts,
> -                                     &m->option_offset);
> -       } else {
> -               fprintf(stderr, " failed to find target %s\n\n",
> -                       t->u.user.name);
> -               return -1;
> -       }
> -
> -       fprintf(f, "\ttarget ");
> -       m->print(NULL, m->t, 0);
> -       if (tb[TCA_IPT_INDEX] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt target index\n");
> -       } else {
> -               __u32 index;
> -
> -               index =3D rta_getattr_u32(tb[TCA_IPT_INDEX]);
> -               fprintf(f, "\n\tindex %u", index);
> -       }
> -
> -       if (tb[TCA_IPT_CNT]) {
> -               struct tc_cnt *c  =3D RTA_DATA(tb[TCA_IPT_CNT]);
> -
> -               fprintf(f, " ref %d bind %d", c->refcnt, c->bindcnt);
> -       }
> -       if (show_stats) {
> -               if (tb[TCA_IPT_TM]) {
> -                       struct tcf_t *tm =3D RTA_DATA(tb[TCA_IPT_TM]);
> -
> -                       print_tm(f, tm);
> -               }
> -       }
> -       fprintf(f, "\n");
> -
> -       free_opts(opts);
> -
> -       return 0;
> -}
> -
> -struct action_util ipt_action_util =3D {
> -       .id =3D "ipt",
> -       .parse_aopt =3D parse_ipt,
> -       .print_aopt =3D print_ipt,
> -};
> diff --git a/tc/m_xt.c b/tc/m_xt.c
> deleted file mode 100644
> index 658084378124..000000000000
> --- a/tc/m_xt.c
> +++ /dev/null
> @@ -1,400 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * m_xt.c      xtables based targets
> - *             utilities mostly ripped from iptables <duh, its the linux=
 way>
> - *
> - * Authors:  J Hadi Salim (hadi@cyberus.ca)
> - */
> -
> -#include <sys/socket.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <net/if.h>
> -#include <limits.h>
> -#include <linux/netfilter.h>
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -#include <xtables.h>
> -#include "utils.h"
> -#include "tc_util.h"
> -#include <linux/tc_act/tc_ipt.h>
> -#include <stdio.h>
> -#include <dlfcn.h>
> -#include <getopt.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <netdb.h>
> -#include <stdlib.h>
> -#include <ctype.h>
> -#include <stdarg.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/wait.h>
> -#ifndef XT_LIB_DIR
> -#       define XT_LIB_DIR "/lib/xtables"
> -#endif
> -
> -#ifndef __ALIGN_KERNEL
> -#define __ALIGN_KERNEL(x, a)   \
> -       __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> -#define __ALIGN_KERNEL_MASK(x, mask) \
> -       (((x) + (mask)) & ~(mask))
> -#endif
> -
> -#ifndef ALIGN
> -#define ALIGN(x, a)    __ALIGN_KERNEL((x), (a))
> -#endif
> -
> -static const char *tname =3D "mangle";
> -
> -char *lib_dir;
> -
> -static const char * const ipthooks[] =3D {
> -       "NF_IP_PRE_ROUTING",
> -       "NF_IP_LOCAL_IN",
> -       "NF_IP_FORWARD",
> -       "NF_IP_LOCAL_OUT",
> -       "NF_IP_POST_ROUTING",
> -};
> -
> -static struct option original_opts[] =3D {
> -       {
> -               .name =3D "jump",
> -               .has_arg =3D 1,
> -               .val =3D 'j'
> -       },
> -       {0, 0, 0, 0}
> -};
> -
> -static struct xtables_globals tcipt_globals =3D {
> -       .option_offset =3D 0,
> -       .program_name =3D "tc-ipt",
> -       .program_version =3D "0.2",
> -       .orig_opts =3D original_opts,
> -       .opts =3D original_opts,
> -       .exit_err =3D NULL,
> -#if XTABLES_VERSION_CODE >=3D 11
> -       .compat_rev =3D xtables_compatible_revision,
> -#endif
> -};
> -
> -/*
> - * we may need to check for version mismatch
> -*/
> -static int
> -build_st(struct xtables_target *target, struct xt_entry_target *t)
> -{
> -
> -       size_t size =3D
> -                   XT_ALIGN(sizeof(struct xt_entry_target)) + target->si=
ze;
> -
> -       if (t =3D=3D NULL) {
> -               target->t =3D xtables_calloc(1, size);
> -               target->t->u.target_size =3D size;
> -               strncpy(target->t->u.user.name, target->name,
> -                       sizeof(target->t->u.user.name) - 1);
> -               target->t->u.user.revision =3D target->revision;
> -
> -               if (target->init !=3D NULL)
> -                       target->init(target->t);
> -       } else {
> -               target->t =3D t;
> -       }
> -       return 0;
> -
> -}
> -
> -static void set_lib_dir(void)
> -{
> -
> -       lib_dir =3D getenv("XTABLES_LIBDIR");
> -       if (!lib_dir) {
> -               lib_dir =3D getenv("IPTABLES_LIB_DIR");
> -               if (lib_dir)
> -                       fprintf(stderr, "using deprecated IPTABLES_LIB_DI=
R\n");
> -       }
> -       if (lib_dir =3D=3D NULL)
> -               lib_dir =3D XT_LIB_DIR;
> -
> -}
> -
> -static int get_xtables_target_opts(struct xtables_globals *globals,
> -                                  struct xtables_target *m)
> -{
> -       struct option *opts;
> -
> -#if XTABLES_VERSION_CODE >=3D 6
> -       opts =3D xtables_options_xfrm(globals->orig_opts,
> -                                   globals->opts,
> -                                   m->x6_options,
> -                                   &m->option_offset);
> -#else
> -       opts =3D xtables_merge_options(globals->opts,
> -                                    m->extra_opts,
> -                                    &m->option_offset);
> -#endif
> -       if (!opts)
> -               return -1;
> -       globals->opts =3D opts;
> -       return 0;
> -}
> -
> -static int parse_ipt(struct action_util *a, int *argc_p,
> -                    char ***argv_p, int tca_id, struct nlmsghdr *n)
> -{
> -       struct xtables_target *m =3D NULL;
> -#if XTABLES_VERSION_CODE >=3D 6
> -       struct ipt_entry fw =3D {};
> -#endif
> -       struct rtattr *tail;
> -
> -       int c;
> -       char **argv =3D *argv_p;
> -       int argc;
> -       char k[FILTER_NAMESZ];
> -       int size =3D 0;
> -       int iok =3D 0, ok =3D 0;
> -       __u32 hook =3D 0, index =3D 0;
> -
> -       /* copy tcipt_globals because .opts will be modified by iptables =
*/
> -       struct xtables_globals tmp_tcipt_globals =3D tcipt_globals;
> -
> -       xtables_init_all(&tmp_tcipt_globals, NFPROTO_IPV4);
> -       set_lib_dir();
> -
> -       /* parse only up until the next action */
> -       for (argc =3D 0; argc < *argc_p; argc++) {
> -               if (!argv[argc] || !strcmp(argv[argc], "action"))
> -                       break;
> -       }
> -
> -       if (argc <=3D 2) {
> -               fprintf(stderr,
> -                       "too few arguments for xt, need at least '-j <tar=
get>'\n");
> -               return -1;
> -       }
> -
> -       while (1) {
> -               c =3D getopt_long(argc, argv, "j:", tmp_tcipt_globals.opt=
s, NULL);
> -               if (c =3D=3D -1)
> -                       break;
> -               switch (c) {
> -               case 'j':
> -                       m =3D xtables_find_target(optarg, XTF_TRY_LOAD);
> -                       if (!m) {
> -                               fprintf(stderr,
> -                                       " failed to find target %s\n\n",
> -                                       optarg);
> -                               return -1;
> -                       }
> -
> -                       if (build_st(m, NULL) < 0) {
> -                               printf(" %s error\n", m->name);
> -                               return -1;
> -                       }
> -
> -                       if (get_xtables_target_opts(&tmp_tcipt_globals,
> -                                                   m) < 0) {
> -                               fprintf(stderr,
> -                                       " failed to find additional optio=
ns for target %s\n\n",
> -                                       optarg);
> -                               return -1;
> -                       }
> -                       ok++;
> -                       break;
> -
> -               default:
> -#if XTABLES_VERSION_CODE >=3D 6
> -                       if (m !=3D NULL && m->x6_parse !=3D NULL) {
> -                               xtables_option_tpcall(c, argv, 0, m, &fw)=
;
> -#else
> -                       if (m !=3D NULL && m->parse !=3D NULL) {
> -                               m->parse(c - m->option_offset, argv, 0,
> -                                        &m->tflags, NULL, &m->t);
> -#endif
> -                       } else {
> -                               fprintf(stderr,
> -                                       "failed to find target %s\n\n", o=
ptarg);
> -                               return -1;
> -
> -                       }
> -                       ok++;
> -                       break;
> -               }
> -       }
> -
> -       if (argc > optind) {
> -               if (matches(argv[optind], "index") =3D=3D 0) {
> -                       if (get_u32(&index, argv[optind + 1], 10)) {
> -                               fprintf(stderr, "Illegal \"index\"\n");
> -                               xtables_free_opts(1);
> -                               return -1;
> -                       }
> -                       iok++;
> -
> -                       optind +=3D 2;
> -               }
> -       }
> -
> -       if (!ok && !iok) {
> -               fprintf(stderr, " ipt Parser BAD!! (%s)\n", *argv);
> -               return -1;
> -       }
> -
> -       /* check that we passed the correct parameters to the target */
> -#if XTABLES_VERSION_CODE >=3D 6
> -       if (m)
> -               xtables_option_tfcall(m);
> -#else
> -       if (m && m->final_check)
> -               m->final_check(m->tflags);
> -#endif
> -
> -       {
> -               struct tcmsg *t =3D NLMSG_DATA(n);
> -
> -               if (t->tcm_parent !=3D TC_H_ROOT
> -                   && t->tcm_parent =3D=3D TC_H_MAJ(TC_H_INGRESS)) {
> -                       hook =3D NF_IP_PRE_ROUTING;
> -               } else {
> -                       hook =3D NF_IP_POST_ROUTING;
> -               }
> -       }
> -
> -       tail =3D addattr_nest(n, MAX_MSG, tca_id);
> -       fprintf(stdout, "tablename: %s hook: %s\n ", tname, ipthooks[hook=
]);
> -       fprintf(stdout, "\ttarget: ");
> -
> -       if (m) {
> -               if (m->print)
> -                       m->print(NULL, m->t, 0);
> -               else
> -                       printf("%s ", m->name);
> -       }
> -       fprintf(stdout, " index %d\n", index);
> -
> -       if (strlen(tname) >=3D 16) {
> -               size =3D 15;
> -               k[15] =3D 0;
> -       } else {
> -               size =3D 1 + strlen(tname);
> -       }
> -       strncpy(k, tname, size);
> -
> -       addattr_l(n, MAX_MSG, TCA_IPT_TABLE, k, size);
> -       addattr_l(n, MAX_MSG, TCA_IPT_HOOK, &hook, 4);
> -       addattr_l(n, MAX_MSG, TCA_IPT_INDEX, &index, 4);
> -       if (m)
> -               addattr_l(n, MAX_MSG, TCA_IPT_TARG, m->t, m->t->u.target_=
size);
> -       addattr_nest_end(n, tail);
> -
> -       argv +=3D optind;
> -       *argc_p -=3D argc;
> -       *argv_p =3D argv;
> -
> -       optind =3D 0;
> -       xtables_free_opts(1);
> -
> -       if (m) {
> -               /* Clear flags if target will be used again */
> -               m->tflags =3D 0;
> -               m->used =3D 0;
> -               /* Free allocated memory */
> -               free(m->t);
> -       }
> -
> -       return 0;
> -
> -}
> -
> -static int
> -print_ipt(struct action_util *au, FILE *f, struct rtattr *arg)
> -{
> -       struct xtables_target *m;
> -       struct rtattr *tb[TCA_IPT_MAX + 1];
> -       struct xt_entry_target *t =3D NULL;
> -       __u32 hook;
> -
> -       if (arg =3D=3D NULL)
> -               return 0;
> -
> -       /* copy tcipt_globals because .opts will be modified by iptables =
*/
> -       struct xtables_globals tmp_tcipt_globals =3D tcipt_globals;
> -
> -       xtables_init_all(&tmp_tcipt_globals, NFPROTO_IPV4);
> -       set_lib_dir();
> -
> -       parse_rtattr_nested(tb, TCA_IPT_MAX, arg);
> -
> -       if (tb[TCA_IPT_TABLE] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt table name, assuming mangle\=
n");
> -       } else {
> -               fprintf(f, "tablename: %s ",
> -                       rta_getattr_str(tb[TCA_IPT_TABLE]));
> -       }
> -
> -       if (tb[TCA_IPT_HOOK] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt hook name\n ");
> -               return -1;
> -       }
> -
> -       if (tb[TCA_IPT_TARG] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt target parameters\n");
> -               return -1;
> -       }
> -
> -       hook =3D rta_getattr_u32(tb[TCA_IPT_HOOK]);
> -       fprintf(f, " hook: %s\n", ipthooks[hook]);
> -
> -       t =3D RTA_DATA(tb[TCA_IPT_TARG]);
> -       m =3D xtables_find_target(t->u.user.name, XTF_TRY_LOAD);
> -       if (!m) {
> -               fprintf(stderr, " failed to find target %s\n\n",
> -                       t->u.user.name);
> -               return -1;
> -       }
> -       if (build_st(m, t) < 0) {
> -               fprintf(stderr, " %s error\n", m->name);
> -               return -1;
> -       }
> -
> -       if (get_xtables_target_opts(&tmp_tcipt_globals, m) < 0) {
> -               fprintf(stderr,
> -                       " failed to find additional options for target %s=
\n\n",
> -                       t->u.user.name);
> -               return -1;
> -       }
> -       fprintf(f, "\ttarget ");
> -       m->print(NULL, m->t, 0);
> -       if (tb[TCA_IPT_INDEX] =3D=3D NULL) {
> -               fprintf(f, " [NULL ipt target index ]\n");
> -       } else {
> -               __u32 index;
> -
> -               index =3D rta_getattr_u32(tb[TCA_IPT_INDEX]);
> -               fprintf(f, "\n\tindex %u", index);
> -       }
> -
> -       if (tb[TCA_IPT_CNT]) {
> -               struct tc_cnt *c  =3D RTA_DATA(tb[TCA_IPT_CNT]);
> -
> -               fprintf(f, " ref %d bind %d", c->refcnt, c->bindcnt);
> -       }
> -       if (show_stats) {
> -               if (tb[TCA_IPT_TM]) {
> -                       struct tcf_t *tm =3D RTA_DATA(tb[TCA_IPT_TM]);
> -
> -                       print_tm(f, tm);
> -               }
> -       }
> -       print_nl();
> -
> -       xtables_free_opts(1);
> -
> -       return 0;
> -}
> -
> -struct action_util xt_action_util =3D {
> -       .id =3D "xt",
> -       .parse_aopt =3D parse_ipt,
> -       .print_aopt =3D print_ipt,
> -};
> diff --git a/tc/m_xt_old.c b/tc/m_xt_old.c
> deleted file mode 100644
> index 9987d606a59c..000000000000
> --- a/tc/m_xt_old.c
> +++ /dev/null
> @@ -1,432 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * m_xt.c      xtables based targets
> - *             utilities mostly ripped from iptables <duh, its the linux=
 way>
> - *
> - * Authors:  J Hadi Salim (hadi@cyberus.ca)
> - */
> -
> -/*XXX: in the future (xtables 1.4.3?) get rid of everything tagged
> - * as TC_CONFIG_XT_H */
> -
> -#include <sys/socket.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <net/if.h>
> -#include <linux/netfilter.h>
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -#include <xtables.h>
> -#include "utils.h"
> -#include "tc_util.h"
> -#include <linux/tc_act/tc_ipt.h>
> -#include <stdio.h>
> -#include <getopt.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <netdb.h>
> -#include <stdlib.h>
> -#include <ctype.h>
> -#include <stdarg.h>
> -#include <limits.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/wait.h>
> -#ifdef TC_CONFIG_XT_H
> -#include "xt-internal.h"
> -#endif
> -
> -#ifndef ALIGN
> -#define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a)-1)
> -#define __ALIGN_MASK(x, mask)  (((x)+(mask))&~(mask))
> -#endif
> -
> -static const char *pname =3D "tc-ipt";
> -static const char *tname =3D "mangle";
> -static const char *pversion =3D "0.2";
> -
> -static const char *ipthooks[] =3D {
> -       "NF_IP_PRE_ROUTING",
> -       "NF_IP_LOCAL_IN",
> -       "NF_IP_FORWARD",
> -       "NF_IP_LOCAL_OUT",
> -       "NF_IP_POST_ROUTING",
> -};
> -
> -static struct option original_opts[] =3D {
> -       {"jump", 1, 0, 'j'},
> -       {0, 0, 0, 0}
> -};
> -
> -static struct option *opts =3D original_opts;
> -static unsigned int global_option_offset;
> -char *lib_dir;
> -const char *program_version =3D XTABLES_VERSION;
> -const char *program_name =3D "tc-ipt";
> -struct afinfo afinfo =3D {
> -       .family         =3D AF_INET,
> -       .libprefix      =3D "libxt_",
> -       .ipproto        =3D IPPROTO_IP,
> -       .kmod           =3D "ip_tables",
> -       .so_rev_target  =3D IPT_SO_GET_REVISION_TARGET,
> -};
> -
> -
> -#define OPTION_OFFSET 256
> -
> -/*XXX: TC_CONFIG_XT_H */
> -static void free_opts(struct option *local_opts)
> -{
> -       if (local_opts !=3D original_opts) {
> -               free(local_opts);
> -               opts =3D original_opts;
> -               global_option_offset =3D 0;
> -       }
> -}
> -
> -/*XXX: TC_CONFIG_XT_H */
> -static struct option *
> -merge_options(struct option *oldopts, const struct option *newopts,
> -             unsigned int *option_offset)
> -{
> -       struct option *merge;
> -       unsigned int num_old, num_new, i;
> -
> -       for (num_old =3D 0; oldopts[num_old].name; num_old++);
> -       for (num_new =3D 0; newopts[num_new].name; num_new++);
> -
> -       *option_offset =3D global_option_offset + OPTION_OFFSET;
> -
> -       merge =3D malloc(sizeof(struct option) * (num_new + num_old + 1))=
;
> -       memcpy(merge, oldopts, num_old * sizeof(struct option));
> -       for (i =3D 0; i < num_new; i++) {
> -               merge[num_old + i] =3D newopts[i];
> -               merge[num_old + i].val +=3D *option_offset;
> -       }
> -       memset(merge + num_old + num_new, 0, sizeof(struct option));
> -
> -       return merge;
> -}
> -
> -
> -/*XXX: TC_CONFIG_XT_H */
> -#ifndef TRUE
> -#define TRUE 1
> -#endif
> -#ifndef FALSE
> -#define FALSE 0
> -#endif
> -
> -/*XXX: TC_CONFIG_XT_H */
> -int
> -check_inverse(const char option[], int *invert, int *my_optind, int argc=
)
> -{
> -       if (option && strcmp(option, "!") =3D=3D 0) {
> -               if (*invert)
> -                       exit_error(PARAMETER_PROBLEM,
> -                                  "Multiple `!' flags not allowed");
> -               *invert =3D TRUE;
> -               if (my_optind !=3D NULL) {
> -                       ++*my_optind;
> -                       if (argc && *my_optind > argc)
> -                               exit_error(PARAMETER_PROBLEM,
> -                                          "no argument following `!'");
> -               }
> -
> -               return TRUE;
> -       }
> -       return FALSE;
> -}
> -
> -/*XXX: TC_CONFIG_XT_H */
> -void exit_error(enum exittype status, const char *msg, ...)
> -{
> -       va_list args;
> -
> -       va_start(args, msg);
> -       fprintf(stderr, "%s v%s: ", pname, pversion);
> -       vfprintf(stderr, msg, args);
> -       va_end(args);
> -       fprintf(stderr, "\n");
> -       /* On error paths, make sure that we don't leak memory */
> -       exit(status);
> -}
> -
> -/*XXX: TC_CONFIG_XT_H */
> -static void set_revision(char *name, u_int8_t revision)
> -{
> -       /* Old kernel sources don't have ".revision" field,
> -       *  but we stole a byte from name. */
> -       name[IPT_FUNCTION_MAXNAMELEN - 2] =3D '\0';
> -       name[IPT_FUNCTION_MAXNAMELEN - 1] =3D revision;
> -}
> -
> -/*
> - * we may need to check for version mismatch
> -*/
> -int
> -build_st(struct xtables_target *target, struct xt_entry_target *t)
> -{
> -
> -       size_t size =3D
> -                   XT_ALIGN(sizeof(struct xt_entry_target)) + target->si=
ze;
> -
> -       if (t =3D=3D NULL) {
> -               target->t =3D fw_calloc(1, size);
> -               target->t->u.target_size =3D size;
> -               strcpy(target->t->u.user.name, target->name);
> -               set_revision(target->t->u.user.name, target->revision);
> -
> -               if (target->init !=3D NULL)
> -                       target->init(target->t);
> -       } else {
> -               target->t =3D t;
> -       }
> -       return 0;
> -
> -}
> -
> -inline void set_lib_dir(void)
> -{
> -
> -       lib_dir =3D getenv("XTABLES_LIBDIR");
> -       if (!lib_dir) {
> -               lib_dir =3D getenv("IPTABLES_LIB_DIR");
> -               if (lib_dir)
> -                       fprintf(stderr, "using deprecated IPTABLES_LIB_DI=
R\n");
> -       }
> -       if (lib_dir =3D=3D NULL)
> -               lib_dir =3D XT_LIB_DIR;
> -
> -}
> -
> -static int parse_ipt(struct action_util *a, int *argc_p,
> -                    char ***argv_p, int tca_id, struct nlmsghdr *n)
> -{
> -       struct xtables_target *m =3D NULL;
> -       struct ipt_entry fw;
> -       struct rtattr *tail;
> -       int c;
> -       int rargc =3D *argc_p;
> -       char **argv =3D *argv_p;
> -       int argc =3D 0, iargc =3D 0;
> -       char k[FILTER_NAMESZ];
> -       int size =3D 0;
> -       int iok =3D 0, ok =3D 0;
> -       __u32 hook =3D 0, index =3D 0;
> -
> -       set_lib_dir();
> -
> -       {
> -               int i;
> -
> -               for (i =3D 0; i < rargc; i++) {
> -                       if (!argv[i] || strcmp(argv[i], "action") =3D=3D =
0)
> -                               break;
> -               }
> -               iargc =3D argc =3D i;
> -       }
> -
> -       if (argc <=3D 2) {
> -               fprintf(stderr, "bad arguments to ipt %d vs %d\n", argc, =
rargc);
> -               return -1;
> -       }
> -
> -       while (1) {
> -               c =3D getopt_long(argc, argv, "j:", opts, NULL);
> -               if (c =3D=3D -1)
> -                       break;
> -               switch (c) {
> -               case 'j':
> -                       m =3D find_target(optarg, TRY_LOAD);
> -                       if (m !=3D NULL) {
> -
> -                               if (build_st(m, NULL) < 0) {
> -                                       printf(" %s error\n", m->name);
> -                                       return -1;
> -                               }
> -                               opts =3D
> -                                   merge_options(opts, m->extra_opts,
> -                                                 &m->option_offset);
> -                       } else {
> -                               fprintf(stderr, " failed to find target %=
s\n\n", optarg);
> -                               return -1;
> -                       }
> -                       ok++;
> -                       break;
> -
> -               default:
> -                       memset(&fw, 0, sizeof(fw));
> -                       if (m) {
> -                               m->parse(c - m->option_offset, argv, 0,
> -                                        &m->tflags, NULL, &m->t);
> -                       } else {
> -                               fprintf(stderr, " failed to find target %=
s\n\n", optarg);
> -                               return -1;
> -
> -                       }
> -                       ok++;
> -                       break;
> -
> -               }
> -       }
> -
> -       if (iargc > optind) {
> -               if (matches(argv[optind], "index") =3D=3D 0) {
> -                       if (get_u32(&index, argv[optind + 1], 10)) {
> -                               fprintf(stderr, "Illegal \"index\"\n");
> -                               free_opts(opts);
> -                               return -1;
> -                       }
> -                       iok++;
> -
> -                       optind +=3D 2;
> -               }
> -       }
> -
> -       if (!ok && !iok) {
> -               fprintf(stderr, " ipt Parser BAD!! (%s)\n", *argv);
> -               return -1;
> -       }
> -
> -       /* check that we passed the correct parameters to the target */
> -       if (m)
> -               m->final_check(m->tflags);
> -
> -       {
> -               struct tcmsg *t =3D NLMSG_DATA(n);
> -
> -               if (t->tcm_parent !=3D TC_H_ROOT
> -                   && t->tcm_parent =3D=3D TC_H_MAJ(TC_H_INGRESS)) {
> -                       hook =3D NF_IP_PRE_ROUTING;
> -               } else {
> -                       hook =3D NF_IP_POST_ROUTING;
> -               }
> -       }
> -
> -       tail =3D addattr_nest(n, MAX_MSG, tca_id);
> -       fprintf(stdout, "tablename: %s hook: %s\n ", tname, ipthooks[hook=
]);
> -       fprintf(stdout, "\ttarget: ");
> -
> -       if (m)
> -               m->print(NULL, m->t, 0);
> -       fprintf(stdout, " index %d\n", index);
> -
> -       if (strlen(tname) > 16) {
> -               size =3D 16;
> -               k[15] =3D 0;
> -       } else {
> -               size =3D 1 + strlen(tname);
> -       }
> -       strncpy(k, tname, size);
> -
> -       addattr_l(n, MAX_MSG, TCA_IPT_TABLE, k, size);
> -       addattr_l(n, MAX_MSG, TCA_IPT_HOOK, &hook, 4);
> -       addattr_l(n, MAX_MSG, TCA_IPT_INDEX, &index, 4);
> -       if (m)
> -               addattr_l(n, MAX_MSG, TCA_IPT_TARG, m->t, m->t->u.target_=
size);
> -       addattr_nest_end(n, tail);
> -
> -       argc -=3D optind;
> -       argv +=3D optind;
> -       *argc_p =3D rargc - iargc;
> -       *argv_p =3D argv;
> -
> -       optind =3D 0;
> -       free_opts(opts);
> -       /* Clear flags if target will be used again */
> -       m->tflags =3D 0;
> -       m->used =3D 0;
> -       /* Free allocated memory */
> -       free(m->t);
> -
> -
> -       return 0;
> -
> -}
> -
> -static int
> -print_ipt(struct action_util *au, FILE * f, struct rtattr *arg)
> -{
> -       struct rtattr *tb[TCA_IPT_MAX + 1];
> -       struct xt_entry_target *t =3D NULL;
> -       struct xtables_target *m;
> -       __u32 hook;
> -
> -       if (arg =3D=3D NULL)
> -               return 0;
> -
> -       set_lib_dir();
> -
> -       parse_rtattr_nested(tb, TCA_IPT_MAX, arg);
> -
> -       if (tb[TCA_IPT_TABLE] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt table name, assuming mangle\=
n");
> -       } else {
> -               fprintf(f, "tablename: %s ",
> -                       rta_getattr_str(tb[TCA_IPT_TABLE]));
> -       }
> -
> -       if (tb[TCA_IPT_HOOK] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt hook name\n");
> -               return -1;
> -       }
> -
> -       if (tb[TCA_IPT_TARG] =3D=3D NULL) {
> -               fprintf(stderr, "Missing ipt target parameters\n");
> -               return -1;
> -       }
> -
> -       hook =3D rta_getattr_u32(tb[TCA_IPT_HOOK]);
> -       fprintf(f, " hook: %s\n", ipthooks[hook]);
> -
> -       t =3D RTA_DATA(tb[TCA_IPT_TARG]);
> -       m =3D find_target(t->u.user.name, TRY_LOAD);
> -       if (m !=3D NULL) {
> -               if (build_st(m, t) < 0) {
> -                       fprintf(stderr, " %s error\n", m->name);
> -                       return -1;
> -               }
> -
> -               opts =3D
> -                       merge_options(opts, m->extra_opts,
> -                                     &m->option_offset);
> -       } else {
> -               fprintf(stderr, " failed to find target %s\n\n",
> -                       t->u.user.name);
> -               return -1;
> -       }
> -       fprintf(f, "\ttarget ");
> -       m->print(NULL, m->t, 0);
> -       if (tb[TCA_IPT_INDEX] =3D=3D NULL) {
> -               fprintf(f, " [NULL ipt target index ]\n");
> -       } else {
> -               __u32 index;
> -
> -               index =3D rta_getattr_u32(tb[TCA_IPT_INDEX]);
> -               fprintf(f, "\n\tindex %u", index);
> -       }
> -
> -       if (tb[TCA_IPT_CNT]) {
> -               struct tc_cnt *c  =3D RTA_DATA(tb[TCA_IPT_CNT]);
> -
> -               fprintf(f, " ref %d bind %d", c->refcnt, c->bindcnt);
> -       }
> -       if (show_stats) {
> -               if (tb[TCA_IPT_TM]) {
> -                       struct tcf_t *tm =3D RTA_DATA(tb[TCA_IPT_TM]);
> -
> -                       print_tm(f, tm);
> -               }
> -       }
> -       fprintf(f, "\n");
> -
> -       free_opts(opts);
> -
> -       return 0;
> -}
> -
> -struct action_util ipt_action_util =3D {
> -       .id =3D "ipt",
> -       .parse_aopt =3D parse_ipt,
> -       .print_aopt =3D print_ipt,
> -};
> --
> 2.43.0
>

