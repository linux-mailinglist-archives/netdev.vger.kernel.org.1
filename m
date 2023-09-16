Return-Path: <netdev+bounces-34210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74627A2CD4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66401C20AF1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC51FA3;
	Sat, 16 Sep 2023 01:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337A1C33
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:06:33 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1DC7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so3275732276.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694826390; x=1695431190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uny5Yv3KDQfD5mM5SNTbKH4rEXdPSE7AwsrsgKZUqVM=;
        b=WpQIJG0ANatih3CjVtjmDMsxVicq5tVT6k2QuE1x+hlmPrjw/FKI23FgigYqqwDS9/
         3s3obdnqo/OyuASvgU+sVnLGHre7uClaS5cy+cmbE1QDkfFRbkbqVKuBbwooaymvyuFE
         gsG57LA9LQFtgxvwFw4LvGlkzeFCg908PnKSwYBQObFNXLGOu93BQ3dkBYAOCCbAcVfl
         gUFfQmdJLcqNGpAXDTyOKHe0g9Y9w9gnWUUqEBy5odd+RwCgzhsJ4kuqP3CtwENDNOSE
         kq1k2Hb9Dmlq/FJPwdOdOamEZvRl3tDC5TIQbfHRqIlDebC6560nobiNAon+qhf7/Zis
         ec5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826390; x=1695431190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uny5Yv3KDQfD5mM5SNTbKH4rEXdPSE7AwsrsgKZUqVM=;
        b=WO7AePRy648W7CPOP/Sf3/aM0bxMDkpj70xD4o5AF6N4dQGYwsvP7h2hSqqrKE+Ey5
         1mgRWrTtpv2nQzVNZE/SWwEUOPi91Br+mB8YoL59iHh8981Se5KA8R1naBWus5bWvS5Y
         PR9n6RTwlRLpJPmR38OgB5wY5lQPH5LgT+5Qf+i5HBgIoGgvuYSI+mcZ8x+ceBxH9+vf
         WUaaOqsZUjxv0iBbLivkBnEhWTb1dGxKBF5mk+c0boMx6Xzn9BAB+vnXLR0GDeLRrnCV
         rNGmZUuNsCgPF7tTZosQHmX2/nZP01StzC3MdQ1/nkfxuCDhbLTlg041VzvxHILA63rU
         JL9g==
X-Gm-Message-State: AOJu0YxVTdvmPfu1gMBJ0TGeX+1tJePDSyZoiocMIMaN3/Rz+a2bQIP7
	OEirjXoum7W6tEDJZynUIh4b3UVQBDtwaCI=
X-Google-Smtp-Source: AGHT+IFnmHQqTBRRmAi0e57sOlKCtaAwjUyuXoADhHnmbrTu4ikEsOS5vThVwotOqry1rLjfBztAXfAs0r2D0KI=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with SMTP
 id m10-20020a056902118a00b00d80183c92b9mr87095ybu.4.1694826390122; Fri, 15
 Sep 2023 18:06:30 -0700 (PDT)
Date: Sat, 16 Sep 2023 01:06:21 +0000
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916010625.2771731-2-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Analyzed a few structs in the networking stack by looking at variables
within them that are used in the TCP/IP fast path.

Fast path is defined as TCP path where data is transferred from sender to
receiver unidirectionaly. It doesn't include phases other than
TCP_ESTABLISHED, nor does it look at error paths.

We hope to re-organizing variables that span many cachelines whose fast
path variables are also spread out, and this document can help future
developers keep networking fast path cachelines small.

Optimized_cacheline field is computed as
(Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
results (see patches to come for these).

Investigation is done on 6.5

Name	                Struct_Cachelines  Cur_fastpath_cache Fastpath_Bytes O=
ptimized_cacheline
tcp_sock	        42 (2664 Bytes)	   12   		396		8
net_device	        39 (2240 bytes)	   12			234		4
inet_sock	        15 (960 bytes)	   14			922		14
Inet_connection_sock	22 (1368 bytes)	   18			1166		18
Netns_ipv4 (sysctls)	12 (768 bytes)     4			77		2
linux_mib	        16 (1060)	   6			104		2

Note how there isn't much improvement space for inet_sock and
Inet_connection_sock becuase sk and icsk_inet respective take up so
much of the struct that rest of the variables become a small portion of
the struct size.

So, we decided to reorganize tcp_sock, net_device, Netns_ipv4, linux_mib

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 .../net_cachelines/inet_connection_sock.rst   |  42 +++++
 .../networking/net_cachelines/inet_sock.rst   |  37 ++++
 .../networking/net_cachelines/net_device.rst  | 167 ++++++++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 151 ++++++++++++++++
 .../networking/net_cachelines/snmp.rst        | 128 ++++++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 148 ++++++++++++++++
 6 files changed, 673 insertions(+)
 create mode 100644 Documentation/networking/net_cachelines/inet_connection=
_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysc=
tl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.r=
st b/Documentation/networking/net_cachelines/inet_connection_sock.rst
new file mode 100644
index 0000000000000..121c706393733
--- /dev/null
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -0,0 +1,42 @@
+..struct                            inet_connection_sock   fastpath_tx_acc=
ess  fastpath_rx_access  comment
+struct_inet_sock                    icsk_inet              read_mostly    =
     read_mostly         tcp_init_buffer_space,tcp_init_transfer,tcp_finish=
_connect,tcp_connect,tcp_send_rcvq,tcp_send_syn_data
+struct_request_sock_queue           icsk_accept_queue      -              =
     -                  =20
+struct_inet_bind_bucket             icsk_bind_hash         read_mostly    =
     -                   tcp_set_state
+struct_inet_bind2_bucket            icsk_bind2_hash        read_mostly    =
     -                   tcp_set_state,inet_put_port
+unsigned_long                       icsk_timeout           read_mostly    =
     -                   inet_csk_reset_xmit_timer,tcp_connect
+struct_timer_list                   icsk_retransmit_timer  read_mostly    =
     -                   inet_csk_reset_xmit_timer,tcp_connect
+struct_timer_list                   icsk_delack_timer      read_mostly    =
     -                   inet_csk_reset_xmit_timer,tcp_connect
+u32                                 icsk_rto               read_write     =
     -                   tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_conn=
ect_init,tcp_connect,tcp_write_xmit,tcp_push_one
+u32                                 icsk_rto_min           -              =
     -                  =20
+u32                                 icsk_delack_max        -              =
     -                  =20
+u32                                 icsk_pmtu_cookie       read_write     =
     -                   tcp_sync_mss,tcp_current_mss,tcp_send_syn_data,tcp=
_connect_init,tcp_connect
+struct_tcp_congestion_ops           icsk_ca_ops            read_write     =
     -                   tcp_cwnd_validate,tcp_tso_segs,tcp_ca_dst_init,tcp=
_connect_init,tcp_connect,tcp_write_xmit
+struct_inet_connection_sock_af_ops  icsk_af_ops            read_mostly    =
     -                   tcp_finish_connect,tcp_send_syn_data,tcp_mtup_init=
,tcp_mtu_check_reprobe,tcp_mtu_probe,tcp_connect_init,tcp_connect,__tcp_tra=
nsmit_skb
+struct_tcp_ulp_ops*                 icsk_ulp_ops           -              =
     -                  =20
+void*                               icsk_ulp_data          -              =
     -                  =20
+u8:5                                icsk_ca_state          read_write     =
     -                   tcp_cwnd_application_limited,tcp_set_ca_state,tcp_=
enter_cwr,tcp_tso_should_defer,tcp_mtu_probe,tcp_schedule_loss_probe,tcp_wr=
ite_xmit,__tcp_transmit_skb
+u8:1                                icsk_ca_initialized    read_write     =
     -                   tcp_init_transfer,tcp_init_congestion_control,tcp_=
init_transfer,tcp_finish_connect,tcp_connect
+u8:1                                icsk_ca_setsockopt     -              =
     -                  =20
+u8:1                                icsk_ca_dst_locked     write_mostly   =
     -                   tcp_ca_dst_init,tcp_connect_init,tcp_connect
+u8                                  icsk_retransmits       write_mostly   =
     -                   tcp_connect_init,tcp_connect
+u8                                  icsk_pending           read_write     =
     -                   inet_csk_reset_xmit_timer,tcp_connect,tcp_check_pr=
obe_timer,__tcp_push_pending_frames,tcp_rearm_rto,tcp_event_new_data_sent,t=
cp_event_new_data_sent
+u8                                  icsk_backoff           write_mostly   =
     -                   tcp_write_queue_purge,tcp_connect_init
+u8                                  icsk_syn_retries       -              =
     -                  =20
+u8                                  icsk_probes_out        -              =
     -                  =20
+u16                                 icsk_ext_hdr_len       read_mostly    =
     -                   __tcp_mtu_to_mss,tcp_mtu_to_rss,tcp_mtu_probe,tcp_=
write_xmit,tcp_mtu_to_mss,
+struct_icsk_ack_u8                  pending                read_write     =
     read_write          inet_csk_ack_scheduled,__tcp_cleanup_rbuf,tcp_clea=
nup_rbuf,inet_csk_clear_xmit_timer,tcp_event_ack-sent,inet_csk_reset_xmit_t=
imer
+struct_icsk_ack_u8                  quick                  read_write     =
     write_mostly        tcp_dec_quickack_mode,tcp_event_ack_sent,__tcp_tra=
nsmit_skb,__tcp_select_window,__tcp_cleanup_rbuf
+struct_icsk_ack_u8                  pingpong               -              =
     -                  =20
+struct_icsk_ack_u8                  retry                  write_mostly   =
     read_write          inet_csk_clear_xmit_timer,tcp_rearm_rto,tcp_event_=
new_data_sent,tcp_write_xmit,__tcp_send_ack,tcp_send_ack,
+struct_icsk_ack_u8                  ato                    read_mostly    =
     write_mostly        tcp_dec_quickack_mode,tcp_event_ack_sent,__tcp_tra=
nsmit_skb,__tcp_send_ack,tcp_send_ack
+struct_icsk_ack_unsigned_long       timeout                read_write     =
     read_write          inet_csk_reset_xmit_timer,tcp_connect
+struct_icsk_ack_u32                 lrcvtime               read_write     =
     -                   tcp_finish_connect,tcp_connect,tcp_event_data_sent=
,__tcp_transmit_skb
+struct_icsk_ack_u16                 rcv_mss                write_mostly   =
     read_mostly         __tcp_select_window,__tcp_cleanup_rbuf,tcp_initial=
ize_rcv_mss,tcp_connect_init
+struct_icsk_mtup_int                search_high            read_write     =
     -                   tcp_mtup_init,tcp_sync_mss,tcp_connect_init,tcp_mt=
u_check_reprobe,tcp_write_xmit
+struct_icsk_mtup_int                search_low             read_write     =
     -                   tcp_mtu_probe,tcp_mtu_check_reprobe,tcp_write_xmit=
,tcp_sync_mss,tcp_connect_init,tcp_mtup_init
+struct_icsk_mtup_u32:31             probe_size             read_write     =
     -                   tcp_mtup_init,tcp_connect_init,__tcp_transmit_skb
+struct_icsk_mtup_u32:1              enabled                read_write     =
     -                   tcp_mtup_init,tcp_sync_mss,tcp_connect_init,tcp_mt=
u_probe,tcp_write_xmit
+struct_icsk_mtup_u32                probe_timestamp        read_write     =
     -                   tcp_mtup_init,tcp_connect_init,tcp_mtu_check_repro=
be,tcp_mtu_probe
+u32                                 icsk_probes_tstamp     -              =
     -                  =20
+u32                                 icsk_user_timeout      -              =
     -                  =20
+u64[104/sizeof(u64)]                icsk_ca_priv           -              =
     -                  =20
diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Docume=
ntation/networking/net_cachelines/inet_sock.rst
new file mode 100644
index 0000000000000..7d5d645c1d3ae
--- /dev/null
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -0,0 +1,37 @@
+Type                    Name                  fastpath_tx_access  fastpath=
_rx_access  comment
+..struct                inet_sock                                         =
           =20
+struct_sock             sk                    read_mostly         read_mos=
tly         tcp_init_buffer_space,tcp_init_transfer,tcp_finish_connect,tcp_=
connect,tcp_send_rcvq,tcp_send_syn_data
+struct_ipv6_pinfo*      pinet6                -                   -       =
           =20
+be16                    inet_sport            read_mostly         -       =
            __tcp_transmit_skb
+be32                    inet_daddr            read_mostly         -       =
            ip_select_ident_segs
+be32                    inet_rcv_saddr        -                   -       =
           =20
+be16                    inet_dport            read_mostly         -       =
            __tcp_transmit_skb
+u16                     inet_num              -                   -       =
           =20
+be32                    inet_saddr            -                   -       =
           =20
+s16                     uc_ttl                read_mostly         -       =
            __ip_queue_xmit/ip_select_ttl
+u16                     cmsg_flags            -                   -       =
           =20
+struct_ip_options_rcu*  inet_opt              read_mostly         -       =
            __ip_queue_xmit
+u16                     inet_id               read_mostly         -       =
            ip_select_ident_segs
+u8                      tos                   read_mostly         -       =
            ip_queue_xmit
+u8                      min_ttl               -                   -       =
           =20
+u8                      mc_ttl                -                   -       =
           =20
+u8                      pmtudisc              -                   -       =
           =20
+u8:1                    recverr               -                   -       =
           =20
+u8:1                    is_icsk               -                   -       =
           =20
+u8:1                    freebind              -                   -       =
           =20
+u8:1                    hdrincl               -                   -       =
           =20
+u8:1                    mc_loop               -                   -       =
           =20
+u8:1                    transparent           -                   -       =
           =20
+u8:1                    mc_all                -                   -       =
           =20
+u8:1                    nodefrag              -                   -       =
           =20
+u8:1                    bind_address_no_port  -                   -       =
           =20
+u8:1                    recverr_rfc4884       -                   -       =
           =20
+u8:1                    defer_connect         read_mostly         -       =
            tcp_sendmsg_fastopen
+u8                      rcv_tos               -                   -       =
           =20
+u8                      convert_csum          -                   -       =
           =20
+int                     uc_index              -                   -       =
           =20
+int                     mc_index              -                   -       =
           =20
+be32                    mc_addr               -                   -       =
           =20
+struct_ip_mc_socklist*  mc_list               -                   -       =
           =20
+struct_inet_cork_full   cork                  read_mostly         -       =
            __tcp_transmit_skb
+struct                  local_port_range      -                   -       =
           =20
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Docum=
entation/networking/net_cachelines/net_device.rst
new file mode 100644
index 0000000000000..c62db082dfa6c
--- /dev/null
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -0,0 +1,167 @@
+Type                                Name                    fastpath_tx_ac=
cess  fastpath_rx_access  Comments
+..struct                            ..net_device                          =
                         =20
+char                                name[16]                -             =
      -                  =20
+struct_netdev_name_node*            name_node                             =
                         =20
+struct_dev_ifalias*                 ifalias                               =
                         =20
+unsigned_long                       mem_end                               =
                         =20
+unsigned_long                       mem_start                             =
                         =20
+unsigned_long                       base_addr                             =
                         =20
+unsigned_long                       state                                 =
                         =20
+struct_list_head                    dev_list                              =
                         =20
+struct_list_head                    napi_list                             =
                         =20
+struct_list_head                    unreg_list                            =
                         =20
+struct_list_head                    close_list                            =
                         =20
+struct_list_head                    ptype_all               read_mostly   =
      -                   dev_nit_active(tx)
+struct_list_head                    ptype_specific                        =
      read_mostly         deliver_ptype_list_skb/__netif_receive_skb_core(r=
x)
+struct                              adj_list                              =
                         =20
+unsigned_int                        flags                   read_mostly   =
      read_mostly         __dev_queue_xmit,__dev_xmit_skb,ip6_output,__ip6_=
finish_output(tx);ip6_rcv_core(rx)
+xdp_features_t                      xdp_features                          =
                         =20
+unsigned_long_long                  priv_flags              read_mostly   =
      -                   __dev_queue_xmit(tx)
+struct_net_device_ops*              netdev_ops              read_mostly   =
      -                   netdev_core_pick_tx,netdev_start_xmit(tx)
+struct_xdp_metadata_ops*            xdp_metadata_ops                      =
                         =20
+int                                 ifindex                 -             =
      read_mostly         ip6_rcv_core
+unsigned_short                      gflags                                =
                         =20
+unsigned_short                      hard_header_len         read_mostly   =
      read_mostly         ip6_xmit(tx);gro_list_prepare(rx)
+unsigned_int                        mtu                     read_mostly   =
      -                   ip_finish_output2
+unsigned_short                      needed_headroom         read_mostly   =
      -                   LL_RESERVED_SPACE/ip_finish_output2
+unsigned_short                      needed_tailroom                       =
                         =20
+netdev_features_t                   features                read_mostly   =
      read_mostly         HARD_TX_LOCK,netif_skb_features,sk_setup_caps(tx)=
;netif_elide_gro(rx)
+netdev_features_t                   hw_features                           =
                         =20
+netdev_features_t                   wanted_features                       =
                         =20
+netdev_features_t                   vlan_features                         =
                         =20
+netdev_features_t                   hw_enc_features         -             =
      -                   netif_skb_features
+netdev_features_t                   mpls_features                         =
                         =20
+netdev_features_t                   gso_partial_features                  =
                         =20
+unsigned_int                        min_mtu                               =
                         =20
+unsigned_int                        max_mtu                               =
                         =20
+unsigned_short                      type                                  =
                         =20
+unsigned_char                       min_header_len                        =
                         =20
+unsigned_char                       name_assign_type                      =
                         =20
+int                                 group                                 =
                         =20
+struct_net_device_stats             stats                                 =
                         =20
+struct_net_device_core_stats*       core_stats                            =
                         =20
+atomic_t                            carrier_up_count                      =
                         =20
+atomic_t                            carrier_down_count                    =
                         =20
+struct_iw_handler_def*              wireless_handlers                     =
                         =20
+struct_iw_public_data*              wireless_data                         =
                         =20
+struct_ethtool_ops*                 ethtool_ops                           =
                         =20
+struct_l3mdev_ops*                  l3mdev_ops                            =
                         =20
+struct_ndisc_ops*                   ndisc_ops                             =
                         =20
+struct_xfrmdev_ops*                 xfrmdev_ops                           =
                         =20
+struct_tlsdev_ops*                  tlsdev_ops                            =
                         =20
+struct_header_ops*                  header_ops              read_mostly   =
      -                   ip_finish_output2,ip6_finish_output2(tx)
+unsigned_char                       operstate                             =
                         =20
+unsigned_char                       link_mode                             =
                         =20
+unsigned_char                       if_port                               =
                         =20
+unsigned_char                       dma                                   =
                         =20
+unsigned_char                       perm_addr[32]                         =
                         =20
+unsigned_char                       addr_assign_type                      =
                         =20
+unsigned_char                       addr_len                              =
                         =20
+unsigned_char                       upper_level                           =
                         =20
+unsigned_char                       lower_level                           =
                         =20
+unsigned_short                      neigh_priv_len                        =
                         =20
+unsigned_short                      padded                                =
                         =20
+spinlock_t                          addr_list_lock                        =
                         =20
+int                                 irq                                   =
                         =20
+struct_netdev_hw_addr_list          uc                                    =
                         =20
+struct_netdev_hw_addr_list          mc                                    =
                         =20
+struct_netdev_hw_addr_list          dev_addrs                             =
                         =20
+struct_kset*                        queues_kset                           =
                         =20
+struct_list_head                    unlink_list                           =
                         =20
+unsigned_int                        promiscuity                           =
                         =20
+unsigned_int                        allmulti                              =
                         =20
+bool                                uc_promisc                            =
                         =20
+unsigned_char                       nested_level                          =
                         =20
+struct_in_device*                   ip_ptr                  read_mostly   =
      read_mostly         __in_dev_get
+struct_inet6_dev*                   ip6_ptr                 read_mostly   =
      read_mostly         __in6_dev_get
+struct_vlan_info*                   vlan_info                             =
                         =20
+struct_dsa_port*                    dsa_ptr                               =
                         =20
+struct_tipc_bearer*                 tipc_ptr                              =
                         =20
+void*                               atalk_ptr                             =
                         =20
+void*                               ax25_ptr                              =
                         =20
+struct_wireless_dev*                ieee80211_ptr                         =
                         =20
+struct_wpan_dev*                    ieee802154_ptr                        =
                         =20
+struct_mpls_dev*                    mpls_ptr                              =
                         =20
+struct_mctp_dev*                    mctp_ptr                              =
                         =20
+unsigned_char*                      dev_addr                              =
                         =20
+struct_netdev_queue*                _rx                     read_mostly   =
      -                   netdev_get_rx_queue(rx)
+unsigned_int                        num_rx_queues                         =
                         =20
+unsigned_int                        real_num_rx_queues      -             =
      read_mostly         get_rps_cpu
+struct_bpf_prog*                    xdp_prog                              =
                         =20
+unsigned_long                       gro_flush_timeout       -             =
      read_mostly         napi_complete_done
+int                                 napi_defer_hard_irqs    -             =
      read_mostly         napi_complete_done
+unsigned_int                        gro_max_size            -             =
      read_mostly         skb_gro_receive
+unsigned_int                        gro_ipv4_max_size       -             =
      read_mostly         skb_gro_receive
+rx_handler_func_t*                  rx_handler              read_mostly   =
      -                   __netif_receive_skb_core
+void*                               rx_handler_data         read_mostly   =
      -                  =20
+struct_mini_Qdisc*                  miniq_ingress                         =
                         =20
+struct_netdev_queue*                ingress_queue           read_mostly   =
      -                  =20
+struct_nf_hook_entries*             nf_hooks_ingress                      =
                         =20
+unsigned_char                       broadcast[32]                         =
                         =20
+struct_cpu_rmap*                    rx_cpu_rmap                           =
                         =20
+struct_hlist_node                   index_hlist                           =
                         =20
+struct_netdev_queue*                _tx                     read_mostly   =
      -                   netdev_get_tx_queue(tx)
+unsigned_int                        num_tx_queues           -             =
      -                  =20
+unsigned_int                        real_num_tx_queues      read_mostly   =
      -                   skb_tx_hash,netdev_core_pick_tx(tx)
+unsigned_int                        tx_queue_len                          =
                         =20
+spinlock_t                          tx_global_lock                        =
                         =20
+struct_xdp_dev_bulk_queue__percpu*  xdp_bulkq                             =
                         =20
+struct_xps_dev_maps*                xps_maps[2]             read_mostly   =
      -                   __netif_set_xps_queue
+struct_mini_Qdisc*                  miniq_egress                          =
                         =20
+struct_nf_hook_entries*             nf_hooks_egress         read_mostly   =
      -                  =20
+struct_hlist_head                   qdisc_hash[16]                        =
                         =20
+struct_timer_list                   watchdog_timer                        =
                         =20
+int                                 watchdog_timeo                        =
                         =20
+u32                                 proto_down_reason                     =
                         =20
+struct_list_head                    todo_list                             =
                         =20
+int__percpu*                        pcpu_refcnt                           =
                         =20
+refcount_t                          dev_refcnt                            =
                         =20
+struct_ref_tracker_dir              refcnt_tracker                        =
                         =20
+struct_list_head                    link_watch_list                       =
                         =20
+enum:8                              reg_state                             =
                         =20
+bool                                dismantle                             =
                         =20
+enum:16                             rtnl_link_state                       =
                         =20
+bool                                needs_free_netdev                     =
                         =20
+void*priv_destructor                struct_net_device                     =
                         =20
+struct_netpoll_info*                npinfo                  -             =
      read_mostly         napi_poll/napi_poll_lock
+possible_net_t                      nd_net                  -             =
      read_mostly         (dev_net)napi_busy_loop,tcp_v(4/6)_rcv,ip(v6)_rcv=
,ip(6)_input,ip(6)_input_finish
+void*                               ml_priv                               =
                         =20
+enum_netdev_ml_priv_type            ml_priv_type                          =
                         =20
+struct_pcpu_lstats__percpu*         lstats                                =
                         =20
+struct_pcpu_sw_netstats__percpu*    tstats                                =
                         =20
+struct_pcpu_dstats__percpu*         dstats                                =
                         =20
+struct_garp_port*                   garp_port                             =
                         =20
+struct_mrp_port*                    mrp_port                              =
                         =20
+struct_dm_hw_stat_delta*            dm_private                            =
                         =20
+struct_device                       dev                     -             =
      -                  =20
+struct_attribute_group*             sysfs_groups[4]                       =
                         =20
+struct_attribute_group*             sysfs_rx_queue_group                  =
                         =20
+struct_rtnl_link_ops*               rtnl_link_ops                         =
                         =20
+unsigned_int                        gso_max_size            read_mostly   =
      -                   sk_dst_gso_max_size
+unsigned_int                        tso_max_size                          =
                         =20
+u16                                 gso_max_segs            read_mostly   =
      -                   gso_max_segs
+u16                                 tso_max_segs                          =
                         =20
+unsigned_int                        gso_ipv4_max_size       read_mostly   =
      -                   sk_dst_gso_max_size
+struct_dcbnl_rtnl_ops*              dcbnl_ops                             =
                         =20
+s16                                 num_tc                  read_mostly   =
      -                   skb_tx_hash
+struct_netdev_tc_txq                tc_to_txq[16]           read_mostly   =
      -                   skb_tx_hash
+u8                                  prio_tc_map[16]                       =
                         =20
+unsigned_int                        fcoe_ddp_xid                          =
                         =20
+struct_netprio_map*                 priomap                               =
                         =20
+struct_phy_device*                  phydev                                =
                         =20
+struct_sfp_bus*                     sfp_bus                               =
                         =20
+struct_lock_class_key*              qdisc_tx_busylock                     =
                         =20
+bool                                proto_down                            =
                         =20
+unsigned:1                          wol_enabled                           =
                         =20
+unsigned:1                          threaded                -             =
      read_mostly         napi_poll(napi_enable,dev_set_threaded)
+struct_list_head                    net_notifier_list                     =
                         =20
+struct_macsec_ops*                  macsec_ops                            =
                         =20
+struct_udp_tunnel_nic_info*         udp_tunnel_nic_info                   =
                         =20
+struct_udp_tunnel_nic*              udp_tunnel_nic                        =
                         =20
+struct_bpf_xdp_entity               xdp_state[3]                          =
                         =20
+u8                                  dev_addr_shadow[32]                   =
                         =20
+netdevice_tracker                   linkwatch_dev_tracker                 =
                         =20
+netdevice_tracker                   watchdog_dev_tracker                  =
                         =20
+netdevice_tracker                   dev_registered_tracker                =
                         =20
+struct_rtnl_hw_stats64*             offload_xstats_l3                     =
                         =20
+struct_devlink_port*                devlink_port                          =
                         =20
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst =
b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
new file mode 100644
index 0000000000000..b51619422ce99
--- /dev/null
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -0,0 +1,151 @@
+Type                            Name                                      =
   fastpath_tx_access  fastpath_rx_access  comment
+..struct                        ..netns_ipv4                              =
                                          =20
+struct_inet_timewait_death_row  tcp_death_row                             =
                                          =20
+struct_udp_table*               udp_table                                 =
                                          =20
+struct_ctl_table_header*        forw_hdr                                  =
                                          =20
+struct_ctl_table_header*        frags_hdr                                 =
                                          =20
+struct_ctl_table_header*        ipv4_hdr                                  =
                                          =20
+struct_ctl_table_header*        route_hdr                                 =
                                          =20
+struct_ctl_table_header*        xfrm4_hdr                                 =
                                          =20
+struct_ipv4_devconf*            devconf_all                               =
                                          =20
+struct_ipv4_devconf*            devconf_dflt                              =
                                          =20
+struct_ip_ra_chain              ra_chain                                  =
                                          =20
+struct_mutex                    ra_mutex                                  =
                                          =20
+struct_fib_rules_ops*           rules_ops                                 =
                                          =20
+struct_fib_table                fib_main                                  =
                                          =20
+struct_fib_table                fib_default                               =
                                          =20
+unsigned_int                    fib_rules_require_fldissect               =
                                          =20
+bool                            fib_has_custom_rules                      =
                                          =20
+bool                            fib_has_custom_local_routes               =
                                          =20
+bool                            fib_offload_disabled                      =
                                          =20
+atomic_t                        fib_num_tclassid_users                    =
                                          =20
+struct_hlist_head*              fib_table_hash                            =
                                          =20
+struct_sock*                    fibnl                                     =
                                          =20
+struct_sock*                    mc_autojoin_sk                            =
                                          =20
+struct_inet_peer_base*          peers                                     =
                                          =20
+struct_fqdir*                   fqdir                                     =
                                          =20
+u8                              sysctl_icmp_echo_ignore_all               =
                                          =20
+u8                              sysctl_icmp_echo_enable_probe             =
                                          =20
+u8                              sysctl_icmp_echo_ignore_broadcasts        =
                                          =20
+u8                              sysctl_icmp_ignore_bogus_error_responses  =
                                          =20
+u8                              sysctl_icmp_errors_use_inbound_ifaddr     =
                                          =20
+int                             sysctl_icmp_ratelimit                     =
                                          =20
+int                             sysctl_icmp_ratemask                      =
                                          =20
+u32                             ip_rt_min_pmtu                            =
   -                   -                  =20
+int                             ip_rt_mtu_expires                         =
   -                   -                  =20
+int                             ip_rt_min_advmss                          =
   -                   -                  =20
+struct_local_ports              ip_local_ports                            =
   -                   -                  =20
+u8                              sysctl_tcp_ecn                            =
   -                   -                  =20
+u8                              sysctl_tcp_ecn_fallback                   =
   -                   -                  =20
+u8                              sysctl_ip_default_ttl                     =
   -                   -                   ip4_dst_hoplimit/ip_select_ttl
+u8                              sysctl_ip_no_pmtu_disc                    =
   -                   -                  =20
+u8                              sysctl_ip_fwd_use_pmtu                    =
   read_mostly         -                   ip_dst_mtu_maybe_forward/ip_skb_=
dst_mtu
+u8                              sysctl_ip_fwd_update_priority             =
   -                   -                   ip_forward
+u8                              sysctl_ip_nonlocal_bind                   =
   -                   -                  =20
+u8                              sysctl_ip_autobind_reuse                  =
   -                   -                  =20
+u8                              sysctl_ip_dynaddr                         =
   -                   -                  =20
+u8                              sysctl_ip_early_demux                     =
   -                   read_mostly         ip(6)_rcv_finish_core
+u8                              sysctl_raw_l3mdev_accept                  =
   -                   -                  =20
+u8                              sysctl_tcp_early_demux                    =
   -                   read_mostly         ip(6)_rcv_finish_core
+u8                              sysctl_udp_early_demux                    =
                                          =20
+u8                              sysctl_nexthop_compat_mode                =
   -                   -                  =20
+u8                              sysctl_fwmark_reflect                     =
   -                   -                  =20
+u8                              sysctl_tcp_fwmark_accept                  =
   -                   -                  =20
+u8                              sysctl_tcp_l3mdev_accept                  =
   -                   -                  =20
+u8                              sysctl_tcp_mtu_probing                    =
   -                   -                  =20
+int                             sysctl_tcp_mtu_probe_floor                =
   -                   -                  =20
+int                             sysctl_tcp_base_mss                       =
   -                   -                  =20
+int                             sysctl_tcp_min_snd_mss                    =
   read_mostly         -                   __tcp_mtu_to_mss(tcp_write_xmit)
+int                             sysctl_tcp_probe_threshold                =
   -                   -                   tcp_mtu_probe(tcp_write_xmit)
+u32                             sysctl_tcp_probe_interval                 =
   -                   -                   tcp_mtu_check_reprobe(tcp_write_=
xmit)
+int                             sysctl_tcp_keepalive_time                 =
   -                   -                  =20
+int                             sysctl_tcp_keepalive_intvl                =
   -                   -                  =20
+u8                              sysctl_tcp_keepalive_probes               =
   -                   -                  =20
+u8                              sysctl_tcp_syn_retries                    =
   -                   -                  =20
+u8                              sysctl_tcp_synack_retries                 =
   -                   -                  =20
+u8                              sysctl_tcp_syncookies                     =
   -                   -                   generated_on_syn
+u8                              sysctl_tcp_migrate_req                    =
   -                   -                   reuseport
+u8                              sysctl_tcp_comp_sack_nr                   =
   -                   -                   __tcp_ack_snd_check
+int                             sysctl_tcp_reordering                     =
   -                   read_mostly         tcp_may_raise_cwnd/tcp_cong_cont=
rol
+u8                              sysctl_tcp_retries1                       =
   -                   -                  =20
+u8                              sysctl_tcp_retries2                       =
   -                   -                  =20
+u8                              sysctl_tcp_orphan_retries                 =
   -                   -                  =20
+u8                              sysctl_tcp_tw_reuse                       =
   -                   -                   timewait_sock_ops
+int                             sysctl_tcp_fin_timeout                    =
   -                   -                   TCP_LAST_ACK/tcp_rcv_state_proce=
ss
+unsigned_int                    sysctl_tcp_notsent_lowat                  =
   read_mostly         -                   tcp_notsent_lowat/tcp_stream_mem=
ory_free
+u8                              sysctl_tcp_sack                           =
   -                   -                   tcp_syn_options
+u8                              sysctl_tcp_window_scaling                 =
   -                   -                   tcp_syn_options,tcp_parse_option=
s
+u8                              sysctl_tcp_timestamps                     =
                                          =20
+u8                              sysctl_tcp_early_retrans                  =
   read_mostly         -                   tcp_schedule_loss_probe(tcp_writ=
e_xmit)
+u8                              sysctl_tcp_recovery                       =
   -                   -                   tcp_fastretrans_alert
+u8                              sysctl_tcp_thin_linear_timeouts           =
   -                   -                   tcp_retrans_timer(on_thin_stream=
s)
+u8                              sysctl_tcp_slow_start_after_idle          =
   -                   -                   unlikely(tcp_cwnd_validate-netwo=
rk-not-starved)
+u8                              sysctl_tcp_retrans_collapse               =
   -                   -                  =20
+u8                              sysctl_tcp_stdurg                         =
   -                   -                   unlikely(tcp_check_urg)
+u8                              sysctl_tcp_rfc1337                        =
   -                   -                  =20
+u8                              sysctl_tcp_abort_on_overflow              =
   -                   -                  =20
+u8                              sysctl_tcp_fack                           =
   -                   -                  =20
+int                             sysctl_tcp_max_reordering                 =
   -                   -                   tcp_check_sack_reordering
+int                             sysctl_tcp_adv_win_scale                  =
   -                   -                   tcp_init_buffer_space
+u8                              sysctl_tcp_dsack                          =
   -                   -                   partial_packet_or_retrans_in_tcp=
_data_queue
+u8                              sysctl_tcp_app_win                        =
   -                   -                   tcp_win_from_space
+u8                              sysctl_tcp_frto                           =
   -                   -                   tcp_enter_loss
+u8                              sysctl_tcp_nometrics_save                 =
   -                   -                   TCP_LAST_ACK/tcp_update_metrics
+u8                              sysctl_tcp_no_ssthresh_metrics_save       =
   -                   -                   TCP_LAST_ACK/tcp_(update/init)_m=
etrics
+u8                              sysctl_tcp_moderate_rcvbuf                =
   read_mostly         read_mostly         tcp_tso_should_defer(tx);tcp_rcv=
_space_adjust(rx)
+u8                              sysctl_tcp_tso_win_divisor                =
   read_mostly         -                   tcp_tso_should_defer(tcp_write_x=
mit)
+u8                              sysctl_tcp_workaround_signed_windows      =
   -                   -                   tcp_select_window
+int                             sysctl_tcp_limit_output_bytes             =
   read_mostly         -                   tcp_small_queue_check(tcp_write_=
xmit)
+int                             sysctl_tcp_challenge_ack_limit            =
   -                   -                  =20
+int                             sysctl_tcp_min_rtt_wlen                   =
   read_mostly         -                   tcp_ack_update_rtt
+u8                              sysctl_tcp_min_tso_segs                   =
   -                   -                   unlikely(icsk_ca_ops-written)
+u8                              sysctl_tcp_tso_rtt_log                    =
   read_mostly         -                   tcp_tso_autosize
+u8                              sysctl_tcp_autocorking                    =
   read_mostly         -                   tcp_push/tcp_should_autocork
+u8                              sysctl_tcp_reflect_tos                    =
   -                   -                   tcp_v(4/6)_send_synack
+int                             sysctl_tcp_invalid_ratelimit              =
   -                   -                  =20
+int                             sysctl_tcp_pacing_ss_ratio                =
   -                   -                   default_cong_cont(tcp_update_pac=
ing_rate)
+int                             sysctl_tcp_pacing_ca_ratio                =
   -                   -                   default_cong_cont(tcp_update_pac=
ing_rate)
+int                             sysctl_tcp_wmem[3]                        =
   read_mostly         -                   tcp_wmem_schedule(sendmsg/sendpa=
ge)
+int                             sysctl_tcp_rmem[3]                        =
   -                   read_mostly         __tcp_grow_window(tx),tcp_rcv_sp=
ace_adjust(rx)
+unsigned_int                    sysctl_tcp_child_ehash_entries            =
                                          =20
+unsigned_long                   sysctl_tcp_comp_sack_delay_ns             =
   -                   -                   __tcp_ack_snd_check
+unsigned_long                   sysctl_tcp_comp_sack_slack_ns             =
   -                   -                   __tcp_ack_snd_check
+int                             sysctl_max_syn_backlog                    =
   -                   -                  =20
+int                             sysctl_tcp_fastopen                       =
   -                   -                  =20
+struct_tcp_congestion_ops       tcp_congestion_control                    =
   -                   -                   init_cc
+struct_tcp_fastopen_context     tcp_fastopen_ctx                          =
   -                   -                  =20
+unsigned_int                    sysctl_tcp_fastopen_blackhole_timeout     =
   -                   -                  =20
+atomic_t                        tfo_active_disable_times                  =
   -                   -                  =20
+unsigned_long                   tfo_active_disable_stamp                  =
   -                   -                  =20
+u32                             tcp_challenge_timestamp                   =
   -                   -                  =20
+u32                             tcp_challenge_count                       =
   -                   -                  =20
+u8                              sysctl_tcp_plb_enabled                    =
   -                   -                  =20
+u8                              sysctl_tcp_plb_idle_rehash_rounds         =
   -                   -                  =20
+u8                              sysctl_tcp_plb_rehash_rounds              =
   -                   -                  =20
+u8                              sysctl_tcp_plb_suspend_rto_sec            =
   -                   -                  =20
+int                             sysctl_tcp_plb_cong_thresh                =
   -                   -                  =20
+int                             sysctl_udp_wmem_min                       =
                                          =20
+int                             sysctl_udp_rmem_min                       =
                                          =20
+u8                              sysctl_fib_notify_on_flag_change          =
                                          =20
+u8                              sysctl_udp_l3mdev_accept                  =
                                          =20
+u8                              sysctl_igmp_llm_reports                   =
                                          =20
+int                             sysctl_igmp_max_memberships               =
                                          =20
+int                             sysctl_igmp_max_msf                       =
                                          =20
+int                             sysctl_igmp_qrv                           =
                                          =20
+struct_ping_group_range         ping_group_range                          =
                                          =20
+atomic_t                        dev_addr_genid                            =
                                          =20
+unsigned_int                    sysctl_udp_child_hash_entries             =
                                          =20
+unsigned_long*                  sysctl_local_reserved_ports               =
                                          =20
+int                             sysctl_ip_prot_sock                       =
                                          =20
+struct_mr_table*                mrt                                       =
                                          =20
+struct_list_head                mr_tables                                 =
                                          =20
+struct_fib_rules_ops*           mr_rules_ops                              =
                                          =20
+u32                             sysctl_fib_multipath_hash_fields          =
                                          =20
+u8                              sysctl_fib_multipath_use_neigh            =
                                          =20
+u8                              sysctl_fib_multipath_hash_policy          =
                                          =20
+struct_fib_notifier_ops*        notifier_ops                              =
                                          =20
+unsigned_int                    fib_seq                                   =
                                          =20
+struct_fib_notifier_ops*        ipmr_notifier_ops                         =
                                          =20
+unsigned_int                    ipmr_seq                                  =
                                          =20
+atomic_t                        rt_genid                                  =
                                          =20
+siphash_key_t                   ip_id_key                                 =
                                                    =20
diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentati=
on/networking/net_cachelines/snmp.rst
new file mode 100644
index 0000000000000..1918a91d45e55
--- /dev/null
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -0,0 +1,128 @@
+Type           Name                                  fastpath_tx_access  f=
astpath_rx_access  comment
+..Timer                                                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPKEEPALIVE                write_mostly        -=
                   tcp_keepalive_timer
+unsigned_long  LINUX_MIB_DELAYEDACKS                 write_mostly        -=
                   tcp_delack_timer_handler,tcp_delack_timer
+unsigned_long  LINUX_MIB_DELAYEDACKLOCKED            write_mostly        -=
                   tcp_delack_timer_handler,tcp_delack_timer
+unsigned_long  LINUX_MIB_TCPAUTOCORKING              write_mostly        -=
                   tcp_push,tcp_sendmsg_locked
+unsigned_long  LINUX_MIB_TCPFROMZEROWINDOWADV        write_mostly        -=
                   tcp_select_window,tcp_transmit-skb
+unsigned_long  LINUX_MIB_TCPTOZEROWINDOWADV          write_mostly        -=
                   tcp_select_window,tcp_transmit-skb
+unsigned_long  LINUX_MIB_TCPWANTZEROWINDOWADV        write_mostly        -=
                   tcp_select_window,tcp_transmit-skb
+unsigned_long  LINUX_MIB_TCPORIGDATASENT             write_mostly        -=
                   tcp_write_xmit
+unsigned_long  LINUX_MIB_TCPHPHITS                   -                   w=
rite_mostly        tcp_rcv_established,tcp_v4_do_rcv,tcp_v6_do_rcv
+unsigned_long  LINUX_MIB_TCPRCVCOALESCE              -                   w=
rite_mostly        tcp_try_coalesce,tcp_queue_rcv,tcp_rcv_established
+unsigned_long  LINUX_MIB_TCPPUREACKS                 -                   w=
rite_mostly        tcp_ack,tcp_rcv_established
+unsigned_long  LINUX_MIB_TCPHPACKS                   -                   w=
rite_mostly        tcp_ack,tcp_rcv_established
+unsigned_long  LINUX_MIB_TCPDELIVERED                -                   w=
rite_mostly        tcp_newly_delivered,tcp_ack,tcp_rcv_established
+unsigned_long  LINUX_MIB_SYNCOOKIESSENT                                   =
                  =20
+unsigned_long  LINUX_MIB_SYNCOOKIESRECV                                   =
                  =20
+unsigned_long  LINUX_MIB_SYNCOOKIESFAILED                                 =
                  =20
+unsigned_long  LINUX_MIB_EMBRYONICRSTS                                    =
                  =20
+unsigned_long  LINUX_MIB_PRUNECALLED                                      =
                  =20
+unsigned_long  LINUX_MIB_RCVPRUNED                                        =
                  =20
+unsigned_long  LINUX_MIB_OFOPRUNED                                        =
                  =20
+unsigned_long  LINUX_MIB_OUTOFWINDOWICMPS                                 =
                  =20
+unsigned_long  LINUX_MIB_LOCKDROPPEDICMPS                                 =
                  =20
+unsigned_long  LINUX_MIB_ARPFILTER                                        =
                  =20
+unsigned_long  LINUX_MIB_TIMEWAITED                                       =
                  =20
+unsigned_long  LINUX_MIB_TIMEWAITRECYCLED                                 =
                  =20
+unsigned_long  LINUX_MIB_TIMEWAITKILLED                                   =
                  =20
+unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED                               =
                  =20
+unsigned_long  LINUX_MIB_PAWSESTABREJECTED                                =
                  =20
+unsigned_long  LINUX_MIB_DELAYEDACKLOST                                   =
                  =20
+unsigned_long  LINUX_MIB_LISTENOVERFLOWS                                  =
                  =20
+unsigned_long  LINUX_MIB_LISTENDROPS                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPRENORECOVERY                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKRECOVERY                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKRENEGING                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKREORDER                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPRENOREORDER                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPTSREORDER                                     =
                  =20
+unsigned_long  LINUX_MIB_TCPFULLUNDO                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPPARTIALUNDO                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKUNDO                                     =
                  =20
+unsigned_long  LINUX_MIB_TCPLOSSUNDO                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPLOSTRETRANSMIT                                =
                  =20
+unsigned_long  LINUX_MIB_TCPRENOFAILURES                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKFAILURES                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPLOSSFAILURES                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTRETRANS                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPSLOWSTARTRETRANS                              =
                  =20
+unsigned_long  LINUX_MIB_TCPTIMEOUTS                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPLOSSPROBES                                    =
                  =20
+unsigned_long  LINUX_MIB_TCPLOSSPROBERECOVERY                             =
                  =20
+unsigned_long  LINUX_MIB_TCPRENORECOVERYFAIL                              =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKRECOVERYFAIL                              =
                  =20
+unsigned_long  LINUX_MIB_TCPRCVCOLLAPSED                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKOLDSENT                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKOFOSENT                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKRECV                                     =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKOFORECV                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTONDATA                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTONCLOSE                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTONMEMORY                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTONTIMEOUT                                =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTONLINGER                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPABORTFAILED                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPMEMORYPRESSURES                               =
                  =20
+unsigned_long  LINUX_MIB_TCPMEMORYPRESSURESCHRONO                         =
                  =20
+unsigned_long  LINUX_MIB_TCPSACKDISCARD                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKIGNOREDOLD                               =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKIGNOREDNOUNDO                            =
                  =20
+unsigned_long  LINUX_MIB_TCPSPURIOUSRTOS                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPMD5NOTFOUND                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPMD5UNEXPECTED                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPMD5FAILURE                                    =
                  =20
+unsigned_long  LINUX_MIB_SACKSHIFTED                                      =
                  =20
+unsigned_long  LINUX_MIB_SACKMERGED                                       =
                  =20
+unsigned_long  LINUX_MIB_SACKSHIFTFALLBACK                                =
                  =20
+unsigned_long  LINUX_MIB_TCPBACKLOGDROP                                   =
                  =20
+unsigned_long  LINUX_MIB_PFMEMALLOCDROP                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPMINTTLDROP                                    =
                  =20
+unsigned_long  LINUX_MIB_TCPDEFERACCEPTDROP                               =
                  =20
+unsigned_long  LINUX_MIB_IPRPFILTER                                       =
                  =20
+unsigned_long  LINUX_MIB_TCPTIMEWAITOVERFLOW                              =
                  =20
+unsigned_long  LINUX_MIB_TCPREQQFULLDOCOOKIES                             =
                  =20
+unsigned_long  LINUX_MIB_TCPREQQFULLDROP                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPRETRANSFAIL                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPBACKLOGCOALESCE                               =
                  =20
+unsigned_long  LINUX_MIB_TCPOFOQUEUE                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPOFODROP                                       =
                  =20
+unsigned_long  LINUX_MIB_TCPOFOMERGE                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPCHALLENGEACK                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPSYNCHALLENGE                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENACTIVE                                =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENACTIVEFAIL                            =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENPASSIVE                               =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENPASSIVEFAIL                           =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENLISTENOVERFLOW                        =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENCOOKIEREQD                            =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENBLACKHOLE                             =
                  =20
+unsigned_long  LINUX_MIB_TCPSPURIOUS_RTX_HOSTQUEUES                       =
                  =20
+unsigned_long  LINUX_MIB_BUSYPOLLRXPACKETS                                =
                  =20
+unsigned_long  LINUX_MIB_TCPSYNRETRANS                                    =
                  =20
+unsigned_long  LINUX_MIB_TCPHYSTARTTRAINDETECT                            =
                  =20
+unsigned_long  LINUX_MIB_TCPHYSTARTTRAINCWND                              =
                  =20
+unsigned_long  LINUX_MIB_TCPHYSTARTDELAYDETECT                            =
                  =20
+unsigned_long  LINUX_MIB_TCPHYSTARTDELAYCWND                              =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDSYNRECV                             =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDPAWS                                =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDSEQ                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDFINWAIT2                            =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDTIMEWAIT                            =
                  =20
+unsigned_long  LINUX_MIB_TCPACKSKIPPEDCHALLENGE                           =
                  =20
+unsigned_long  LINUX_MIB_TCPWINPROBE                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPMTUPFAIL                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPMTUPSUCCESS                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPDELIVEREDCE                                   =
                  =20
+unsigned_long  LINUX_MIB_TCPACKCOMPRESSED                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPZEROWINDOWDROP                                =
                  =20
+unsigned_long  LINUX_MIB_TCPRCVQDROP                                      =
                  =20
+unsigned_long  LINUX_MIB_TCPWQUEUETOOBIG                                  =
                  =20
+unsigned_long  LINUX_MIB_TCPFASTOPENPASSIVEALTKEY                         =
                  =20
+unsigned_long  LINUX_MIB_TCPTIMEOUTREHASH                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPDUPLICATEDATAREHASH                           =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKRECVSEGS                                 =
                  =20
+unsigned_long  LINUX_MIB_TCPDSACKIGNOREDDUBIOUS                           =
                  =20
+unsigned_long  LINUX_MIB_TCPMIGRATEREQSUCCESS                             =
                  =20
+unsigned_long  LINUX_MIB_TCPMIGRATEREQFAILURE                             =
                  =20
+unsigned_long  __LINUX_MIB_MAX                                            =
                  =20
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documen=
tation/networking/net_cachelines/tcp_sock.rst
new file mode 100644
index 0000000000000..ff7c5e933fc35
--- /dev/null
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -0,0 +1,148 @@
+Type                          Name                    fastpath_tx_access  =
fastpath_rx_access  Comments
+..struct                      tcp_sock                                    =
                   =20
+struct_inet_connection_sock   inet_conn                                   =
                   =20
+u16                           tcp_header_len          read_mostly         =
read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_estab=
lished(rx)
+u16                           gso_segs                read_mostly         =
-                   tcp_xmit_size_goal
+__be32                        pred_flags              read_write          =
read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
+u64                           bytes_received          -                   =
read_write          tcp_rcv_nxt_update(rx)
+u32                           segs_in                 -                   =
read_write          tcp_v6_rcv(rx)
+u32                           data_segs_in            -                   =
read_write          tcp_v6_rcv(rx)
+u32                           rcv_nxt                 read_mostly         =
read_write          tcp_cleanup_rbuf,tcp_send_ack,tcp_inq_hint,tcp_transmit=
_skb,tcp_receive_window(tx);tcp_v6_do_rcv,tcp_rcv_established,tcp_data_queu=
e,tcp_receive_window,tcp_rcv_nxt_update(write)(rx)
+u32                           copied_seq              -                   =
read_mostly         tcp_cleanup_rbuf,tcp_rcv_space_adjust,tcp_inq_hint
+u32                           rcv_wup                 -                   =
read_write          __tcp_cleanup_rbuf,tcp_receive_window,tcp_receive_estab=
lished
+u32                           snd_nxt                 read_write          =
read_mostly         tcp_rate_check_app_limited,__tcp_transmit_skb,tcp_event=
_new_data_sent(write)(tx);tcp_rcv_established,tcp_ack,tcp_clean_rtx_queue(r=
x)
+u32                           segs_out                read_write          =
-                   __tcp_transmit_skb
+u32                           data_segs_out           read_write          =
-                   __tcp_transmit_skb,tcp_update_skb_after_send
+u64                           bytes_sent              read_write          =
-                   __tcp_transmit_skb
+u64                           bytes_acked             -                   =
read_write          tcp_snd_una_update/tcp_ack
+u32                           dsack_dups                                  =
                   =20
+u32                           snd_una                 read_mostly         =
read_write          tcp_wnd_end,tcp_urg_mode,tcp_minshall_check,tcp_cwnd_va=
lidate(tx);tcp_ack,tcp_may_update_window,tcp_clean_rtx_queue(write),tcp_ack=
_tstamp(rx)
+u32                           snd_sml                 read_write          =
-                   tcp_minshall_check,tcp_minshall_update
+u32                           rcv_tstamp              -                   =
read_mostly         tcp_ack
+u32                           lsndtime                read_write          =
-                   tcp_slow_start_after_idle_check,tcp_event_data_sent
+u32                           last_oow_ack_time                           =
                   =20
+u32                           compressed_ack_rcv_nxt                      =
                   =20
+u32                           tsoffset                read_mostly         =
read_mostly         tcp_established_options(tx);tcp_fast_parse_options(rx)
+struct_list_head              tsq_node                -                   =
-                  =20
+struct_list_head              tsorted_sent_queue      read_write          =
-                   tcp_update_skb_after_send
+u32                           snd_wl1                 -                   =
read_mostly         tcp_may_update_window
+u32                           snd_wnd                 read_mostly         =
read_mostly         tcp_wnd_end,tcp_tso_should_defer(tx);tcp_fast_path_on(r=
x)
+u32                           max_window              read_mostly         =
-                   tcp_bound_to_half_wnd,forced_push
+u32                           mss_cache               read_mostly         =
read_mostly         tcp_rate_check_app_limited,tcp_current_mss,tcp_sync_mss=
,tcp_sndbuf_expand,tcp_tso_should_defer(tx);tcp_update_pacing_rate,tcp_clea=
n_rtx_queue(rx)
+u32                           window_clamp            read_mostly         =
read_write          tcp_rcv_space_adjust,__tcp_select_window
+u32                           rcv_ssthresh            read_mostly         =
-                   __tcp_select_window
+struct                        tcp_rack                                    =
                   =20
+u16                           advmss                  -                   =
read_mostly         tcp_rcv_space_adjust
+u8                            compressed_ack                              =
                   =20
+u8:2                          dup_ack_counter                             =
                   =20
+u8:1                          tlp_retrans                                 =
                   =20
+u32                           chrono_start            read_write          =
-                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,=
tcp_send_syn_data)
+u32[3]                        chrono_stat             read_write          =
-                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,=
tcp_send_syn_data)
+u8:2                          chrono_type             read_write          =
-                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,=
tcp_send_syn_data)
+u8:1                          rate_app_limited        -                   =
read_write          tcp_rate_gen
+u8:1                          fastopen_connect                            =
                   =20
+u8:1                          fastopen_no_cookie                          =
                   =20
+u8:1                          is_sack_reneg           -                   =
read_mostly         tcp_skb_entail,tcp_ack
+u8:2                          fastopen_client_fail                        =
                   =20
+u8:4                          nonagle                 read_write          =
-                   tcp_skb_entail,tcp_push_pending_frames
+u8:1                          thin_lto                                    =
                   =20
+u8:1                          recvmsg_inq                                 =
                   =20
+u8:1                          repair                  read_mostly         =
-                   tcp_write_xmit
+u8:1                          frto                                        =
                   =20
+u8                            repair_queue            -                   =
-                  =20
+u8:2                          save_syn                                    =
                   =20
+u8:1                          syn_data                                    =
                   =20
+u8:1                          syn_fastopen                                =
                   =20
+u8:1                          syn_fastopen_exp                            =
                   =20
+u8:1                          syn_fastopen_ch                             =
                   =20
+u8:1                          syn_data_acked                              =
                   =20
+u8:1                          is_cwnd_limited         read_mostly         =
-                   tcp_cwnd_validate,tcp_is_cwnd_limited
+u32                           tlp_high_seq            -                   =
read_mostly         tcp_ack
+u32                           tcp_tx_delay                                =
                   =20
+u64                           tcp_wstamp_ns           read_write          =
-                   tcp_pacing_check,tcp_tso_should_defer,tcp_update_skb_af=
ter_send
+u64                           tcp_clock_cache         read_write          =
read_write          tcp_mstamp_refresh(tcp_write_xmit/tcp_rcv_space_adjust)=
,__tcp_transmit_skb,tcp_tso_should_defer;timer
+u64                           tcp_mstamp              read_write          =
read_write          tcp_mstamp_refresh(tcp_write_xmit/tcp_rcv_space_adjust)=
(tx);tcp_rcv_space_adjust,tcp_rate_gen,tcp_clean_rtx_queue,tcp_ack_update_r=
tt/tcp_time_stamp(rx);timer
+u32                           srtt_us                 read_mostly         =
read_write          tcp_tso_should_defer(tx);tcp_update_pacing_rate,__tcp_s=
et_rto,tcp_rtt_estimator(rx)
+u32                           mdev_us                 read_write          =
-                   tcp_rtt_estimator
+u32                           mdev_max_us                                 =
                   =20
+u32                           rttvar_us               -                   =
read_mostly         __tcp_set_rto
+u32                           rtt_seq                 read_write          =
                    tcp_rtt_estimator
+struct_minmax                 rtt_min                 -                   =
read_mostly         tcp_min_rtt/tcp_rate_gen,tcp_min_rtttcp_update_rtt_min
+u32                           packets_out             read_write          =
read_write          tcp_packets_in_flight(tx/rx);tcp_slow_start_after_idle_=
check,tcp_nagle_check,tcp_rate_skb_sent,tcp_event_new_data_sent,tcp_cwnd_va=
lidate,tcp_write_xmit(tx);tcp_ack,tcp_clean_rtx_queue,tcp_update_pacing_rat=
e(rx)
+u32                           retrans_out             -                   =
read_mostly         tcp_packets_in_flight,tcp_rate_check_app_limited
+u32                           max_packets_out         -                   =
read_write          tcp_cwnd_validate
+u32                           cwnd_usage_seq          -                   =
read_write          tcp_cwnd_validate
+u16                           urg_data                -                   =
read_mostly         tcp_fast_path_check
+u8                            ecn_flags               read_write          =
-                   tcp_ecn_send
+u8                            keepalive_probes                            =
                   =20
+u32                           reordering              read_mostly         =
-                   tcp_sndbuf_expand
+u32                           reord_seen                                  =
                   =20
+u32                           snd_up                  read_write          =
read_mostly         tcp_mark_urg,tcp_urg_mode,__tcp_transmit_skb(tx);tcp_cl=
ean_rtx_queue(rx)
+struct_tcp_options_received   rx_opt                  read_mostly         =
read_write          tcp_established_options(tx);tcp_fast_path_on,tcp_ack_up=
date_window,tcp_is_sack,tcp_data_queue,tcp_rcv_established,tcp_ack_update_r=
tt(rx)
+u32                           snd_ssthresh            -                   =
read_mostly         tcp_update_pacing_rate
+u32                           snd_cwnd                read_mostly         =
read_mostly         tcp_snd_cwnd,tcp_rate_check_app_limited,tcp_tso_should_=
defer(tx);tcp_update_pacing_rate
+u32                           snd_cwnd_cnt                                =
                   =20
+u32                           snd_cwnd_clamp                              =
                   =20
+u32                           snd_cwnd_used                               =
                   =20
+u32                           snd_cwnd_stamp                              =
                   =20
+u32                           prior_cwnd                                  =
                   =20
+u32                           prr_delivered                               =
                   =20
+u32                           prr_out                 read_mostly         =
read_mostly         tcp_rate_skb_sent,tcp_newly_delivered(tx);tcp_ack,tcp_r=
ate_gen,tcp_clean_rtx_queue(rx)
+u32                           delivered               read_mostly         =
read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp=
_rate_gen, tcp_clean_rtx_queue (rx)
+u32                           delivered_ce            read_mostly         =
read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
+u32                           lost                    -                   =
read_mostly         tcp_ack
+u32                           app_limited             read_write          =
read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_ra=
te_gen(rx)
+u64                           first_tx_mstamp         read_write          =
-                   tcp_rate_skb_sent
+u64                           delivered_mstamp        read_write          =
-                   tcp_rate_skb_sent
+u32                           rate_delivered          -                   =
read_mostly         tcp_rate_gen
+u32                           rate_interval_us        -                   =
read_mostly         rate_delivered,rate_app_limited
+u32                           rcv_wnd                 read_write          =
read_mostly         tcp_select_window,tcp_receive_window,tcp_fast_path_chec=
k
+u32                           write_seq               read_write          =
-                   tcp_rate_check_app_limited,tcp_write_queue_empty,tcp_sk=
b_entail,forced_push,tcp_mark_push
+u32                           notsent_lowat           read_mostly         =
-                   tcp_stream_memory_free
+u32                           pushed_seq              read_write          =
-                   tcp_mark_push,forced_push
+u32                           lost_out                read_mostly         =
read_mostly         tcp_left_out(tx);tcp_packets_in_flight(tx/rx);tcp_rate_=
check_app_limited(rx)
+u32                           sacked_out              read_mostly         =
read_mostly         tcp_left_out(tx);tcp_packets_in_flight(tx/rx);tcp_clean=
_rtx_queue(rx)
+struct_hrtimer                pacing_timer                                =
                   =20
+struct_hrtimer                compressed_ack_timer                        =
                   =20
+struct_sk_buff*               lost_skb_hint           read_mostly         =
                    tcp_clean_rtx_queue
+struct_sk_buff*               retransmit_skb_hint     read_mostly         =
-                   tcp_clean_rtx_queue
+struct_rb_root                out_of_order_queue      -                   =
read_mostly         tcp_data_queue,tcp_fast_path_check
+struct_sk_buff*               ooo_last_skb                                =
                   =20
+struct_tcp_sack_block[1]      duplicate_sack                              =
                   =20
+struct_tcp_sack_block[4]      selective_acks                              =
                   =20
+struct_tcp_sack_block[4]      recv_sack_cache                             =
                   =20
+struct_sk_buff*               highest_sack            read_write          =
-                   tcp_event_new_data_sent
+int                           lost_cnt_hint                               =
                   =20
+u32                           prior_ssthresh                              =
                   =20
+u32                           high_seq                                    =
                   =20
+u32                           retrans_stamp                               =
                   =20
+u32                           undo_marker                                 =
                   =20
+int                           undo_retrans                                =
                   =20
+u64                           bytes_retrans                               =
                   =20
+u32                           total_retrans                               =
                   =20
+u32                           rto_stamp                                   =
                   =20
+u16                           total_rto                                   =
                   =20
+u16                           total_rto_recoveries                        =
                   =20
+u32                           total_rto_time                              =
                   =20
+u32                           urg_seq                 -                   =
-                  =20
+unsigned_int                  keepalive_time                              =
                   =20
+unsigned_int                  keepalive_intvl                             =
                   =20
+int                           linger2                                     =
                   =20
+u8                            bpf_sock_ops_cb_flags                       =
                   =20
+u8:1                          bpf_chg_cc_inprogress                       =
                   =20
+u16                           timeout_rehash                              =
                   =20
+u32                           rcv_ooopack                                 =
                   =20
+u32                           rcv_rtt_last_tsecr                          =
                   =20
+struct                        rcv_rtt_est             -                   =
read_write          tcp_rcv_space_adjust,tcp_rcv_established
+struct                        rcvq_space              -                   =
read_write          tcp_rcv_space_adjust
+struct                        mtu_probe                                   =
                   =20
+u32                           plb_rehash                                  =
                   =20
+u32                           mtu_info                                    =
                   =20
+bool                          is_mptcp                                    =
                   =20
+bool                          smc_hs_congested                            =
                   =20
+bool                          syn_smc                                     =
                   =20
+struct_tcp_sock_af_ops*       af_specific                                 =
                   =20
+struct_tcp_md5sig_info*       md5sig_info                                 =
                   =20
+struct_tcp_fastopen_request*  fastopen_req                                =
                   =20
+struct_request_sock*          fastopen_rsk                                =
                   =20
+struct_saved_syn*             saved_syn                                   =
                    =20
\ No newline at end of file
--=20
2.42.0.459.ge4e396fd5e-goog


