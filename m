Return-Path: <netdev+bounces-257738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 65SKG+fHhmlMQwQAu9opvQ
	(envelope-from <netdev+bounces-257738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:04:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5717104FAE
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F21D3027689
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35942DC35C;
	Sat,  7 Feb 2026 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaE9r1Re"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4A238D22
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440674; cv=none; b=LXqvvOZdC89eQ1XBKJfbuJtL5pXP2Yu+Da+m6pOurXBW7N39HY90qXFZuuz+tMyXLUivq59+hOSN1kFatgXUQK9bg+MHHW2wwpTi/AaR6Iu7XM0cTLktfRG2S89PfDaFHHJ21iZluCDZOyeM9IxtoFQfAqTvQ3lGLyZ9wPi9XSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440674; c=relaxed/simple;
	bh=YBxFClaRW6qtfLrQ+EW0PUel5S2J5jDd1XY4VaY3QHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq9A03SLhBUq6KssiI04c4/r5Luy2wg4lFScWlrhUe4u8jPOcKFWLGneHGmwdFYMuBFchgySAVPsKA6M6z+7kpVi24A6i+85aEjNPG4c78vX5ENUnUTighFuN/lAVqSofMbGB5B1y5+PRhSL5rVu9wCWm/hmwZpYOkNBEFwqJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaE9r1Re; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770440674; x=1801976674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YBxFClaRW6qtfLrQ+EW0PUel5S2J5jDd1XY4VaY3QHg=;
  b=VaE9r1ReOZ5eBVUr+DapYY1uF/3oFNgU6yyD/jBjVFY9dQajkH17NJvm
   8NWnAevr0ULVP+U+itMzmX7y5G3yWT0Ziiau9f29ha2xkMs7rg6fI1bxC
   RJlyI7WVVaou4Hpak0qxWB2tPHGrA7stBz22wPMsWWRIxQ0jBTXV+agm+
   7mQe4Z5yKlPUjbY2ANgMT5GylontveCLJPSMhD8XplCumr8U/WHN6o10S
   60bzfZX1MISro/Rb3aJCko5sMTruPVih9bgL7KA8QBui2jiacKQBzYhWl
   e2KSmNWtpy/VDHyL21YjIXUpcmTC2oKtIRu4apPVGRBkA2NYwDC1923gO
   Q==;
X-CSE-ConnectionGUID: W/Z4Yol7S2m6AWgl/f/cTA==
X-CSE-MsgGUID: QpkAdtygSISZPOI9d3pSAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71547735"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="71547735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 21:04:34 -0800
X-CSE-ConnectionGUID: 5xLKF+qGQ6OxzltaYiqtKA==
X-CSE-MsgGUID: o2fqTC8RRQe9yOpO2a1/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="215567362"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2026 21:04:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voaUd-00000000lOs-23eY;
	Sat, 07 Feb 2026 05:04:27 +0000
Date: Sat, 7 Feb 2026 13:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	schalla@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <202602071211.N0SvyotM-lkp@intel.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206120154.2548079-1-schalla@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257738-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5717104FAE
X-Rspamd-Action: no action

Hi Srujana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Srujana-Challa/virtio_net-Improve-RSS-key-size-validation-and-use-NETDEV_RSS_KEY_LEN/20260206-200801
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260206120154.2548079-1-schalla%40marvell.com
patch subject: [PATCH v2 net-next] virtio_net: Improve RSS key size validation and use NETDEV_RSS_KEY_LEN
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20260207/202602071211.N0SvyotM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602071211.N0SvyotM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602071211.N0SvyotM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
    6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
         |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +6841 drivers/net/virtio_net.c

  6699	
  6700	static int virtnet_probe(struct virtio_device *vdev)
  6701	{
  6702		int i, err = -ENOMEM;
  6703		struct net_device *dev;
  6704		struct virtnet_info *vi;
  6705		u16 max_queue_pairs;
  6706		int mtu = 0;
  6707	
  6708		/* Find if host supports multiqueue/rss virtio_net device */
  6709		max_queue_pairs = 1;
  6710		if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
  6711			max_queue_pairs =
  6712			     virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));
  6713	
  6714		/* We need at least 2 queue's */
  6715		if (max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
  6716		    max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
  6717		    !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
  6718			max_queue_pairs = 1;
  6719	
  6720		/* Allocate ourselves a network device with room for our info */
  6721		dev = alloc_etherdev_mq(sizeof(struct virtnet_info), max_queue_pairs);
  6722		if (!dev)
  6723			return -ENOMEM;
  6724	
  6725		/* Set up network device as normal. */
  6726		dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
  6727				   IFF_TX_SKB_NO_LINEAR;
  6728		dev->netdev_ops = &virtnet_netdev;
  6729		dev->stat_ops = &virtnet_stat_ops;
  6730		dev->features = NETIF_F_HIGHDMA;
  6731	
  6732		dev->ethtool_ops = &virtnet_ethtool_ops;
  6733		SET_NETDEV_DEV(dev, &vdev->dev);
  6734	
  6735		/* Do we support "hardware" checksums? */
  6736		if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
  6737			/* This opens up the world of extra features. */
  6738			dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_SG;
  6739			if (csum)
  6740				dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
  6741	
  6742			if (virtio_has_feature(vdev, VIRTIO_NET_F_GSO)) {
  6743				dev->hw_features |= NETIF_F_TSO
  6744					| NETIF_F_TSO_ECN | NETIF_F_TSO6;
  6745			}
  6746			/* Individual feature bits: what can host handle? */
  6747			if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_TSO4))
  6748				dev->hw_features |= NETIF_F_TSO;
  6749			if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_TSO6))
  6750				dev->hw_features |= NETIF_F_TSO6;
  6751			if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
  6752				dev->hw_features |= NETIF_F_TSO_ECN;
  6753			if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
  6754				dev->hw_features |= NETIF_F_GSO_UDP_L4;
  6755	
  6756			if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
  6757				dev->hw_features |= NETIF_F_GSO_UDP_TUNNEL;
  6758				dev->hw_enc_features = dev->hw_features;
  6759			}
  6760			if (dev->hw_features & NETIF_F_GSO_UDP_TUNNEL &&
  6761			    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM)) {
  6762				dev->hw_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
  6763				dev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
  6764			}
  6765	
  6766			dev->features |= NETIF_F_GSO_ROBUST;
  6767	
  6768			if (gso)
  6769				dev->features |= dev->hw_features;
  6770			/* (!csum && gso) case will be fixed by register_netdev() */
  6771		}
  6772	
  6773		/* 1. With VIRTIO_NET_F_GUEST_CSUM negotiation, the driver doesn't
  6774		 * need to calculate checksums for partially checksummed packets,
  6775		 * as they're considered valid by the upper layer.
  6776		 * 2. Without VIRTIO_NET_F_GUEST_CSUM negotiation, the driver only
  6777		 * receives fully checksummed packets. The device may assist in
  6778		 * validating these packets' checksums, so the driver won't have to.
  6779		 */
  6780		dev->features |= NETIF_F_RXCSUM;
  6781	
  6782		if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
  6783		    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
  6784			dev->features |= NETIF_F_GRO_HW;
  6785		if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
  6786			dev->hw_features |= NETIF_F_GRO_HW;
  6787	
  6788		dev->vlan_features = dev->features;
  6789		dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
  6790			NETDEV_XDP_ACT_XSK_ZEROCOPY;
  6791	
  6792		/* MTU range: 68 - 65535 */
  6793		dev->min_mtu = MIN_MTU;
  6794		dev->max_mtu = MAX_MTU;
  6795	
  6796		/* Configuration may specify what MAC to use.  Otherwise random. */
  6797		if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
  6798			u8 addr[ETH_ALEN];
  6799	
  6800			virtio_cread_bytes(vdev,
  6801					   offsetof(struct virtio_net_config, mac),
  6802					   addr, ETH_ALEN);
  6803			eth_hw_addr_set(dev, addr);
  6804		} else {
  6805			eth_hw_addr_random(dev);
  6806			dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
  6807				 dev->dev_addr);
  6808		}
  6809	
  6810		/* Set up our device-specific information */
  6811		vi = netdev_priv(dev);
  6812		vi->dev = dev;
  6813		vi->vdev = vdev;
  6814		vdev->priv = vi;
  6815	
  6816		INIT_WORK(&vi->config_work, virtnet_config_changed_work);
  6817		INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
  6818	
  6819		if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
  6820			vi->mergeable_rx_bufs = true;
  6821			dev->xdp_features |= NETDEV_XDP_ACT_RX_SG;
  6822		}
  6823	
  6824		if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
  6825			vi->has_rss_hash_report = true;
  6826	
  6827		if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
  6828			vi->has_rss = true;
  6829	
  6830		if (vi->has_rss || vi->has_rss_hash_report) {
  6831			vi->rss_key_size =
  6832				virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
  6833	
  6834			/* Spec requires at least 40 bytes */
  6835			if (vi->rss_key_size < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
  6836				dev_warn(&vdev->dev,
  6837					 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
  6838					 vi->rss_key_size, VIRTIO_NET_RSS_MIN_KEY_SIZE);
  6839				vi->has_rss = false;
  6840				vi->has_rss_hash_report = false;
> 6841			} else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
  6842				dev_warn(&vdev->dev,
  6843					 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
  6844					 vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
  6845				vi->has_rss = false;
  6846				vi->has_rss_hash_report = false;
  6847			} else {
  6848				vi->rss_indir_table_size =
  6849					virtio_cread16(vdev, offsetof(struct virtio_net_config,
  6850								      rss_max_indirection_table_length));
  6851				vi->rss_hash_types_supported =
  6852				    virtio_cread32(vdev, offsetof(struct virtio_net_config,
  6853								  supported_hash_types));
  6854				vi->rss_hash_types_supported &=
  6855						~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
  6856						  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
  6857						  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
  6858	
  6859				dev->hw_features |= NETIF_F_RXHASH;
  6860				dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
  6861			}
  6862		}
  6863	
  6864		vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
  6865		if (!vi->rss_hdr) {
  6866			err = -ENOMEM;
  6867			goto free;
  6868		}
  6869	
  6870		if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
  6871		    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
  6872			vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
  6873		else if (vi->has_rss_hash_report)
  6874			vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
  6875		else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
  6876			 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
  6877			vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
  6878		else
  6879			vi->hdr_len = sizeof(struct virtio_net_hdr);
  6880	
  6881		if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
  6882			vi->rx_tnl_csum = true;
  6883		if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
  6884			vi->rx_tnl = true;
  6885		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
  6886			vi->tx_tnl = true;
  6887	
  6888		if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
  6889		    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
  6890			vi->any_header_sg = true;
  6891	
  6892		if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
  6893			vi->has_cvq = true;
  6894	
  6895		mutex_init(&vi->cvq_lock);
  6896	
  6897		if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
  6898			mtu = virtio_cread16(vdev,
  6899					     offsetof(struct virtio_net_config,
  6900						      mtu));
  6901			if (mtu < dev->min_mtu) {
  6902				/* Should never trigger: MTU was previously validated
  6903				 * in virtnet_validate.
  6904				 */
  6905				dev_err(&vdev->dev,
  6906					"device MTU appears to have changed it is now %d < %d",
  6907					mtu, dev->min_mtu);
  6908				err = -EINVAL;
  6909				goto free;
  6910			}
  6911	
  6912			dev->mtu = mtu;
  6913			dev->max_mtu = mtu;
  6914		}
  6915	
  6916		virtnet_set_big_packets(vi, mtu);
  6917	
  6918		if (vi->any_header_sg)
  6919			dev->needed_headroom = vi->hdr_len;
  6920	
  6921		/* Enable multiqueue by default */
  6922		if (num_online_cpus() >= max_queue_pairs)
  6923			vi->curr_queue_pairs = max_queue_pairs;
  6924		else
  6925			vi->curr_queue_pairs = num_online_cpus();
  6926		vi->max_queue_pairs = max_queue_pairs;
  6927	
  6928		/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
  6929		err = init_vqs(vi);
  6930		if (err)
  6931			goto free;
  6932	
  6933		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
  6934			vi->intr_coal_rx.max_usecs = 0;
  6935			vi->intr_coal_tx.max_usecs = 0;
  6936			vi->intr_coal_rx.max_packets = 0;
  6937	
  6938			/* Keep the default values of the coalescing parameters
  6939			 * aligned with the default napi_tx state.
  6940			 */
  6941			if (vi->sq[0].napi.weight)
  6942				vi->intr_coal_tx.max_packets = 1;
  6943			else
  6944				vi->intr_coal_tx.max_packets = 0;
  6945		}
  6946	
  6947		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
  6948			/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
  6949			for (i = 0; i < vi->max_queue_pairs; i++)
  6950				if (vi->sq[i].napi.weight)
  6951					vi->sq[i].intr_coal.max_packets = 1;
  6952	
  6953			err = virtnet_init_irq_moder(vi);
  6954			if (err)
  6955				goto free;
  6956		}
  6957	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

