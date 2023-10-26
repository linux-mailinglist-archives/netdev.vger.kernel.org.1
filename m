Return-Path: <netdev+bounces-44444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5AB7D7FEA
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D9CB211AB
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B9286A6;
	Thu, 26 Oct 2023 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GO31yEI0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B827728
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:45:56 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867C10A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:45:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so8042a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698313553; x=1698918353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik0oEwD2x0UjxkF+mBYA9t7kM+iJesc5g6Z8M7TZ7Bs=;
        b=GO31yEI0MIePGDZfBvwIOhkSH92iyo3bn6CjEQZFjiJAMPDCQPG55DyyIUQShfg9dj
         fX+K6jfzfR2e5iClOeHfC3fd0K1eY3+jZy4ZLxd+5y8JZXhlL43lLEdgKF/rMTZut4iT
         9tyDQYrCMqp6+A2f6zQkSiz/gd9con/fL3dd6zvia6UHxPxZcJ03b2iW28+hOwmDZ1om
         5v0AWmp2ab5rONJKhBazP0z1XcxKdWrbxIfzoRNBOQlHoL3+umG9I/z6NxMhP+SAxB46
         RH9QUc5SSLCC9EH97gaZmZFmuVTE4PdU30FtGzBR9qrsgSryFF9i5C12rc7Njh9BNzkA
         cseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313553; x=1698918353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik0oEwD2x0UjxkF+mBYA9t7kM+iJesc5g6Z8M7TZ7Bs=;
        b=NjP0KFzoUf4ACVIwIFuPBTCHfIp51Y2d7xmbMzsqqv4GFX+fk9dVhdKRCvfFWc2dci
         r8K1Hz8+WcJKlbpbE/BBo2+OmsFw55gCW0wC9Q+zJuURtUWQzKqypW02XzS03GiZSup+
         7S+H07at1iXxY/avuN2VnitL9R12WmWXEv4E93ByAdU1S6/ynkbrMDK/25P/UplVpPtM
         RAfTjfV7QzXLOjAFdWzD5AklE0bwA92cQFeohkFmQdokhyCc3ZzJtd3LIPhT6rirH8Cu
         ch70QDYoSYLTi/Vxmuy3pX1n/EK5pZNxkobJjNBKRtjm2XQJkmyG1AwBWddAwn5DZFk1
         mWcQ==
X-Gm-Message-State: AOJu0YwylBAnbaKrLZKz7x+PJCatDZN8sdzvJNsLI9+0gMPODNQhNajg
	sLYqppGHTa7SftyBbzJr1+2xEfDXWQmabA/wQERHdw==
X-Google-Smtp-Source: AGHT+IGjkaZ2qcbxgYarRjQhyWOs3/z72RuFkhHcI7HXuGHkyrDkRITx1enyFy0ggJNcryG1F8H52KkLXH+zaryAOek=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr243948eds.4.1698313552739; Thu, 26 Oct
 2023 02:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com> <20231026081959.3477034-5-lixiaoyan@google.com>
In-Reply-To: <20231026081959.3477034-5-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Oct 2023 11:45:41 +0200
Message-ID: <CANn89iJaavn3aArjc1LDXDs1wfTZV=hUVnreQu=3Dnde=BOEMQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 4/6] netns-ipv4: reorganize netns_ipv4 fast
 path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:20=E2=80=AFAM Coco Li <lixiaoyan@google.com> wro=
te:
>
> Reorganize fast path variables on tx-txrx-rx order.
> Fastpath cacheline ends after sysctl_tcp_rmem.
> There are only read-only variables here. (write is on the control path
> and not considered in this case)
>
> Below data generated with pahole on x86 architecture.
> Fast path variables span cache lines before change: 4
> Fast path variables span cache lines after change: 2
>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
>  fs/proc/proc_net.c       | 39 ++++++++++++++++++++++++++++++++++++
>  include/net/netns/ipv4.h | 43 ++++++++++++++++++++++++++--------------
>  2 files changed, 67 insertions(+), 15 deletions(-)
>
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index 2ba31b6d68c07..38846be34acd9 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -344,6 +344,43 @@ const struct file_operations proc_net_operations =3D=
 {
>         .iterate_shared =3D proc_tgid_net_readdir,
>  };
>
> +static void __init netns_ipv4_struct_check(void)
> +{
> +       /* TX readonly hotpath cache lines */
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_early_retrans);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_tso_win_divisor);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_tso_rtt_log);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_autocorking);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_min_snd_mss);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_notsent_lowat);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_limit_output_bytes);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_min_rtt_wlen);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_wmem);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_ip_fwd_use_pmtu);
> +       /* TXRX readonly hotpath cache lines */
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_moderate_rcvbuf);
> +       /* RX readonly hotpath cache line */
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_ip_early_demux);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_early_demux);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_reordering);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
> +                                     sysctl_tcp_rmem);
> +}
> +
>  static __net_init int proc_net_ns_init(struct net *net)
>  {
>         struct proc_dir_entry *netd, *net_statd;
> @@ -351,6 +388,8 @@ static __net_init int proc_net_ns_init(struct net *ne=
t)
>         kgid_t gid;
>         int err;
>
> +       netns_ipv4_struct_check();
> +
>         /*
>          * This PDE acts only as an anchor for /proc/${pid}/net hierarchy=
.
>          * Corresponding inode (PDE(inode) =3D=3D net->proc_net) is never
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 73f43f6991999..617074fccde68 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -42,6 +42,34 @@ struct inet_timewait_death_row {
>  struct tcp_fastopen_context;
>
>  struct netns_ipv4 {
> +       /* Cacheline organization can be found documented in
> +        * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
> +        * Please update the document when adding new fields.
> +        */
> +
> +       __cacheline_group_begin(netns_ipv4_read);

Same remark here, please use three different groups, instead of a single on=
e.

__cacheline_group_begin(tx_path);

> +       /* TX readonly hotpath cache lines */
> +       u8 sysctl_tcp_early_retrans;
> +       u8 sysctl_tcp_tso_win_divisor;
> +       u8 sysctl_tcp_tso_rtt_log;
> +       u8 sysctl_tcp_autocorking;
> +       int sysctl_tcp_min_snd_mss;
> +       unsigned int sysctl_tcp_notsent_lowat;
> +       int sysctl_tcp_limit_output_bytes;
> +       int sysctl_tcp_min_rtt_wlen;
> +       int sysctl_tcp_wmem[3];
> +       u8 sysctl_ip_fwd_use_pmtu;
> +

__cacheline_group_end(tx_path);
__cacheline_group_begin(rxtx_path);
> +       /* TXRX readonly hotpath cache lines */
> +       u8 sysctl_tcp_moderate_rcvbuf;
> +

__cacheline_group_end(rxtx_path);
__cacheline_group_begin(rx_path);

> +       /* RX readonly hotpath cache line */
> +       u8 sysctl_ip_early_demux;
> +       u8 sysctl_tcp_early_demux;
> +       int sysctl_tcp_reordering;
> +       int sysctl_tcp_rmem[3];
> +       __cacheline_group_end(netns_ipv4_read);

__cacheline_group_end(rx_path);


> +
>         struct inet_timewait_death_row tcp_death_row;
>         struct udp_table *udp_table;
>
> @@ -96,17 +124,14 @@ struct netns_ipv4 {
>
>         u8 sysctl_ip_default_ttl;
>         u8 sysctl_ip_no_pmtu_disc;
> -       u8 sysctl_ip_fwd_use_pmtu;
>         u8 sysctl_ip_fwd_update_priority;
>         u8 sysctl_ip_nonlocal_bind;
>         u8 sysctl_ip_autobind_reuse;
>         /* Shall we try to damage output packets if routing dev changes? =
*/
>         u8 sysctl_ip_dynaddr;
> -       u8 sysctl_ip_early_demux;
>  #ifdef CONFIG_NET_L3_MASTER_DEV
>         u8 sysctl_raw_l3mdev_accept;
>  #endif
> -       u8 sysctl_tcp_early_demux;
>         u8 sysctl_udp_early_demux;
>
>         u8 sysctl_nexthop_compat_mode;
> @@ -119,7 +144,6 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_mtu_probing;
>         int sysctl_tcp_mtu_probe_floor;
>         int sysctl_tcp_base_mss;
> -       int sysctl_tcp_min_snd_mss;
>         int sysctl_tcp_probe_threshold;
>         u32 sysctl_tcp_probe_interval;
>
> @@ -135,17 +159,14 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_backlog_ack_defer;
>         u8 sysctl_tcp_pingpong_thresh;
>
> -       int sysctl_tcp_reordering;
>         u8 sysctl_tcp_retries1;
>         u8 sysctl_tcp_retries2;
>         u8 sysctl_tcp_orphan_retries;
>         u8 sysctl_tcp_tw_reuse;
>         int sysctl_tcp_fin_timeout;
> -       unsigned int sysctl_tcp_notsent_lowat;
>         u8 sysctl_tcp_sack;
>         u8 sysctl_tcp_window_scaling;
>         u8 sysctl_tcp_timestamps;
> -       u8 sysctl_tcp_early_retrans;
>         u8 sysctl_tcp_recovery;
>         u8 sysctl_tcp_thin_linear_timeouts;
>         u8 sysctl_tcp_slow_start_after_idle;
> @@ -161,21 +182,13 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_frto;
>         u8 sysctl_tcp_nometrics_save;
>         u8 sysctl_tcp_no_ssthresh_metrics_save;
> -       u8 sysctl_tcp_moderate_rcvbuf;
> -       u8 sysctl_tcp_tso_win_divisor;
>         u8 sysctl_tcp_workaround_signed_windows;
> -       int sysctl_tcp_limit_output_bytes;
>         int sysctl_tcp_challenge_ack_limit;
> -       int sysctl_tcp_min_rtt_wlen;
>         u8 sysctl_tcp_min_tso_segs;
> -       u8 sysctl_tcp_tso_rtt_log;
> -       u8 sysctl_tcp_autocorking;
>         u8 sysctl_tcp_reflect_tos;
>         int sysctl_tcp_invalid_ratelimit;
>         int sysctl_tcp_pacing_ss_ratio;
>         int sysctl_tcp_pacing_ca_ratio;
> -       int sysctl_tcp_wmem[3];
> -       int sysctl_tcp_rmem[3];
>         unsigned int sysctl_tcp_child_ehash_entries;
>         unsigned long sysctl_tcp_comp_sack_delay_ns;
>         unsigned long sysctl_tcp_comp_sack_slack_ns;
> --
> 2.42.0.758.gaed0368e0e-goog
>

